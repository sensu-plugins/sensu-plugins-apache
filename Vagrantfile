# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = '2'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = 'chef/centos-6.6'
  config.vm.box_download_checksum = true
  config.vm.box_download_checksum_type = 'md5'
  config.vm.hostname = 'sensu-plugins-dev'

  config.berkshelf.enabled = true

  config.vm.provision "chef_zero" do |chef|
    chef.roles_path = '../GIR/roles'
    chef.add_role('base')
    chef.add_recipe 'apache2'
  end
end
