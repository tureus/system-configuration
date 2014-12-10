template "#{node['nginx']['dir']}/sites-available/site" do
  source "nginx/sites-available/twitter-instrument-site.erb"
  owner "root"
  group node['root_group']
  mode '0644'
  variables ({
    :frontend_root => "#{appspec['dir']}/frontend/current/dist"
  })
  notifies :reload, 'service[nginx]'
end

nginx_site "twitter-instrument-site" do
  enable false
end

file "#{node['nginx']['dir']}/sites-available/twitter-instrument-site" do
  action :delete
end

nginx_site "twitter-instrument-site" do
  enable false
end