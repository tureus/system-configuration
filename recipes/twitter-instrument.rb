ssh_known_hosts_entry 'github.com'

include_recipe "nodejs::nodejs_from_binary"

appspec = node['apps']['twitter-instrument']


postgresql_connection_info = {
  :host     => 'localhost',
  :port     => node['postgresql']['config']['port'],
  :username => 'postgres',
  :password => node['postgresql']['password']['postgres']
}

postgresql_database_user appspec['database']['user'] do
  connection postgresql_connection_info
  password appspec['database']['password']
end

postgresql_database appspec['database']['name'] do
  connection postgresql_connection_info
  owner appspec['database']['user']
end

application 'twitter-instrument-frontend' do
  path "#{appspec['dir']}/frontend"
  owner appspec['user']
  group appspec['group']
  repository "git@github.com:xrl/twitter-instrument.git"

  before_deploy do
    directory "#{new_resource.shared_path}/node_modules" do
      owner appspec['user']
      group appspec['group']
    end
    directory "#{new_resource.shared_path}/bower_components" do
      owner appspec['user']
      group appspec['group']
    end
  end

  before_symlink do
    nodejs_npm "bower" do
      version "1.3.12"
    end
  end

  symlinks ({"node_modules" => "node_modules",
             "bower_components" => "bower_components"})

  before_restart do
    execute "install-dependencies" do
      cwd new_resource.release_path
      user appspec['user']
      command "npm install && bower install"
      environment ({"HOME" => "/home/#{appspec['user']}/"})
    end
    execute "build-app" do
      cwd new_resource.release_path
      user appspec['user']
      command "#{new_resource.release_path}/node_modules/ember-cli/bin/ember build"
    end
  end
  action :force_deploy
end

application "twitter-instrument-api" do
  path "#{appspec['dir']}/api"
  owner appspec['user']
  group appspec['group']
  repository "git@github.com:xrl/tureus-api.git"

  rails do
    gems %w(bundler)

    database do
      adapter "postgresql"
      database "tureus-api"
      username appspec['database']['user']
      password appspec['database']['password']
      host appspec['database']['host']
    end

  end

  unicorn do
    forked_user appspec['user']
    forked_group appspec['group']
  end

  migrate true
  migration_command "RAILS_ENV=production rake db:migrate"
end

directory "/home/#{appspec['user']}/api" do
  owner appspec['user']
  group appspec['group']
end

mount "/home/#{appspec['user']}/api" do
  device "#{appspec['dir']}/api/current"
  fstype "none"
  options "bind,rw"
  action [:mount,:enable]
end