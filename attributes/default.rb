default['authorization']['sudo']['passwordless'] = true

default['nginx']['default_site_enabled'] = false

default['apps']['tureus-com']['type'] = 'ember-cli'
default['apps']['tureus-com']['parent_dir'] = '/var/www'
default['apps']['tureus-com']['dir'] = '/var/www/tureus-com'
default['apps']['tureus-com']['user'] = 'xavierlange'
default['apps']['tureus-com']['group'] = 'xavierlange'

default['postgresql']['password']['postgres'] = 'supersecretpassword'
default['postgresql']['enable_pgdg_apt'] = true