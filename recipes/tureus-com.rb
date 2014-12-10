appspec = node['apps']['tureus-com']

directory appspec['dir'] do
  owner appspec['user']
  group appspec['group']
end

application 'tureus-com' do
  path "#{appspec['dir']}"
  owner appspec['user']
  group appspec['group']
  repository "git@bitbucket.org:xrl/tureus-com.git"

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
      command "#{new_resource.release_path}/node_modules/ember-cli/bin/ember build --environment=production"
    end
  end
  action :force_deploy
end

template "#{node['nginx']['dir']}/sites-available/tureus-com" do
  source "nginx/sites-available/tureus-com.erb"
  owner "root"
  group node['root_group']
  mode '0644'
  variables ({
    :root => "#{appspec['dir']}/current/dist"
  })
  notifies :reload, 'service[nginx]'
end

nginx_site "tureus-com" do
  enable true
end