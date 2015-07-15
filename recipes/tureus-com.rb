appspec = node['apps']['tureus-com']

directory appspec['dir']

template "#{node['nginx']['dir']}/sites-available/tureus-com" do
  source "nginx/sites-available/tureus-com.erb"
  owner "root"
  group node['root_group']
  mode '0644'
  variables ({
    :root => "#{appspec['dir']}"
  })
  notifies :reload, 'service[nginx]'
end

site_release_file = "tureus.com-0.1.0.tar.gz"
site_release_folder = site_release_file.gsub('.tar.gz','')
cookbook_file "#{Chef::Config[:file_cache_path]}/#{site_release_file}" do
  source site_release_file
  notifies :run, "bash[unpack-tureus-com]"
end

bash "unpack-tureus-com" do
  code <<-EOH
    rm -rf #{appspec['dir']}
    tar xzf #{Chef::Config[:file_cache_path]}/#{site_release_file} -C #{appspec['parent_dir']}
  EOH

  action :nothing
end

nginx_site "tureus-com" do
  enable true
end