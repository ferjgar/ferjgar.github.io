Vagrant.require_version ">= 1.8.1"

Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"
  # by default, vagrant uses root, and we don't want that for RVM
  config.vm.provision :shell, privileged: false, path: "provision.sh"
  # so you can see the blog on http://localhost:6969
  config.vm.network :forwarded_port, guest: 4000, host: 6969
end
