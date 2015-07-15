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
depends "chef-solo-search"

depends "git"

depends "nginx"

depends "runit"

depends "database"
depends "postgresql"
