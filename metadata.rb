name             'system-configuration'
maintainer       'YOUR_NAME'
maintainer_email 'YOUR_EMAIL'
license          'All rights reserved'
description      'Installs/Configures system-configuration'
long_description 'Installs/Configures system-configuration'
version          '0.1.0'

depends "ssh_known_hosts"
depends "sudo"
depends "users"

depends "git"
depends "npm"

depends "nginx"

depends "runit"

depends "application"
depends "application_ruby"

depends "database"
depends "postgresql"
