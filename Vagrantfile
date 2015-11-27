# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.hostname = "node-app-berkshelf"

  config.vm.box = 'chef/ubuntu-14.04'
  config.vm.network :private_network, ip: "33.33.33.10"

  # config.vm.network :public_network
  # config.vm.synced_folder "../data", "/vagrant_data"
  config.berkshelf.enabled = true
  # config.berkshelf.only = []
  # config.berkshelf.except = []

  config.vm.provision :chef_solo do |chef|
    chef.json = {
      :instance_role => 'vagrant',
      :node_app => {
        :user => 'vagrant',
        :apps => [
          {
            'name' => 'test-app1',
            'url' => 'test1.example.com',
            'port' => 3001,
          },
          {
            'name' => 'test-app2',
            'capistrano_style' => true,
            'url' => 'test2.example.com'
          }

        ]
      },
      :redisio => {
        'version' => '3.0.5',
        'servers' => [ {
          'name' => 'node_app_cache',
          'port' => '6379',
          'address' => '127.0.0.1'
        } ]
      }
    }

    chef.run_list = [
        "recipe[node_app::default]",
        "recipe[redisio]",
        "recipe[redisio::enable]"
    ]
  end
end
