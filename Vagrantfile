# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'json'

VAGRANTFILE_API_VERSION = '2'

# Read in the configuration file for the vagrant environment
config_file = JSON.parse(File.read('../GIR/config/vagrant_config.json'))
vagrant_config = config_file['config']

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # Standard configurtaion details
  config.vm.box_download_checksum = true
  config.vm.box_download_checksum_type = 'md5'
  config.vm.hostname = 'sensu-plugins-dev'

  # Berkself Configuration
  config.berkshelf.enabled = true

  # Box definitions
  config.vm.define 'cent5' do |cent5|
    cent5.vm.box = vagrant_config['cent5']['box']
    cent5.vm.provision 'chef_zero' do |chef|
      chef.roles_path = vagrant_config['cent5']['role_path']
      vagrant_config['cent5']['role'].each do |r|
        chef.add_role(r)
      end
      chef.add_recipe 'apache2'
    end
  end

  config.vm.define 'cent6' do |cent6|
    cent6.vm.box = vagrant_config['cent6']['box']
    cent6.vm.provision 'chef_zero' do |chef|
      chef.roles_path = vagrant_config['cent6']['role_path']
      vagrant_config['cent6']['role'].each do |r|
        chef.add_role(r)
      end
      chef.add_recipe 'apache2'
    end
  end

  config.vm.define 'cent7' do |cent7|
    cent7.vm.box = vagrant_config['cent7']['box']
    cent7.vm.provision 'chef_zero' do |chef|
      chef.roles_path = vagrant_config['cent7']['role_path']
      vagrant_config['cent7']['role'].each do |r|
        chef.add_role(r)
      end
      chef.add_recipe 'apache2'
    end
  end

  config.vm.define 'ubuntu14' do |ubuntu14|
    ubuntu14.vm.box = vagrant_config['ubuntu14']['box']
    ubuntu14.vm.provision 'chef_zero' do |chef|
      chef.roles_path = vagrant_config['ubuntu14']['role_path']
      vagrant_config['ubuntu14']['role'].each do |r|
        chef.add_role(r)
      end
      chef.add_recipe 'apache2'
    end
  end

  config.vm.define 'freebsd92' do |bsd9|
    bsd9.vm.guest = :freebsd
    bsd9.ssh.shell = '/bin/sh'
    bsd9.vm.box = vagrant_config['bsd9']['box']

    # Use NFS as a shared folder
    bsd9.vm.synced_folder ".", "/vagrant", type: 'rsync'
    bsd9.vm.provision 'chef_zero' do |chef|
      chef.synced_folder_type = 'rsync'
      chef.roles_path = vagrant_config['bsd10']['role_path']
      vagrant_config['bsd9']['role'].each do |r|
       chef.add_role(r)
      end
    end
  end

  config.vm.define 'freebsd10' do |bsd10|
    bsd10.vm.guest = :freebsd
    bsd10.vm.box = vagrant_config['bsd10']['box']

    # Use NFS as a shared folder
    bsd10.vm.synced_folder ".", "/vagrant", type: 'rsync'
    bsd10.vm.provision 'chef_zero' do |chef|
      chef.synced_folder_type = 'rsync'
      chef.roles_path = vagrant_config['bsd10']['role_path']
      vagrant_config['bsd10']['role'].each do |r|
       chef.add_role(r)
      end
    end
  end
end
