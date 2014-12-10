default['authorization']['sudo']['passwordless'] = true

default['nginx']['default_site_enabled'] = false

default['apps']['twitter-instrument']['type'] = 'ember-cli-and-rails'
default['apps']['twitter-instrument']['dir'] = '/var/www/twitter-instrument'
default['apps']['twitter-instrument']['user'] = 'xavierlange'
default['apps']['twitter-instrument']['group'] = 'xavierlange'
default['apps']['twitter-instrument']['database']['host'] = 'localhost'
default['apps']['twitter-instrument']['database']['name'] = 'tureus-api'
default['apps']['twitter-instrument']['database']['user'] = 'xavierlange'
default['apps']['twitter-instrument']['database']['password'] = 'wowapassword'
default['apps']['twitter-instrument']['server']['port'] = 3000

default['apps']['tureus-com']['type'] = 'ember-cli'
default['apps']['tureus-com']['dir'] = '/var/www/tureus-com'
default['apps']['tureus-com']['user'] = 'xavierlange'
default['apps']['tureus-com']['group'] = 'xavierlange'

default['postgresql']['password']['postgres'] = 'supersecretpassword'
default['postgresql']['enable_pgdg_apt'] = true