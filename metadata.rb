name             'node_app'
maintainer       'Justin Bodeutsch'
maintainer_email 'lefthand@gmail.com'
license          'All rights reserved'
description      'Add a list of node apps to a server.'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.1'

depends          "starter"
depends          "apache2", ">= 1.8.15" 
depends          "git"
depends          "logrotate"
depends          "nodejs"

supports         "ubuntu"
