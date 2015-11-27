# Attribute driven nodejs app server

# Description

Installs node.js and sets up apache2 as a reverse proxy for any apps defined via attributes. 

# A Longer Description

Do you have a bunch of node.js apps that you want to host on a server? Of course you do! Just include this cookbook in your role or wrapper cookbook's run list and add the details of your app to the hash of the app attribute and you'll be off to the races. 

# Requirements

Ubuntu 14.04

# Attributes

* `node['node_app']['log_path']` - Each app will log to a file in this directory. Default is `/var/log/nodejs`
* `node['node_app']['user']` - The owner of the app. Defaults to 'deploy'. Must be created before this recipe is run.
* `node['node_app']['apps']` - A hash defining the apps that will be created. 
* `node['node_app']['apps'][]['name']` - Required! - The name of the app. Determines the name of the init service. 
* `node['node_app']['apps'][]['url']` - Required! - The URL the proxy will listen for.
* `node['node_app']['apps'][]['template']` - Specify an alternative template for init to use. 
* `node['node_app']['apps'][]['cookbook']` - Specify the name of the cookbook of the template.
* `node['node_app']['apps'][]['port']` - The port the app runs on.
* `node['node_app']['apps'][]['command']` - The command used to start the app.  
* `node['node_app']['apps'][]['capistrano_style']` - Creates directory tree in the style of capistrano.  

# Recipes

Only the default recipe.

# Todo

* Allow nginx or apache to be used as reverse proxy server.

# Author

Author:: Justin Bodeutsch (<lefthand@gmail.com>)
