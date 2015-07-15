#
# Cookbook Name:: system-configuration
# Recipe:: default
#
# Copyright (C) 2014 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "git"
include_recipe "nginx"
include_recipe "runit"

include_recipe "users::sysadmins"
include_recipe "sudo"

include_recipe "postgresql::ruby"
include_recipe "postgresql::server"

include_recipe "system-configuration::packages"

include_recipe "system-configuration::ruby"

include_recipe "system-configuration::tureus-com"
