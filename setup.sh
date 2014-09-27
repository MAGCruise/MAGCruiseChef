#!/bin/sh

if type ruby > /dev/null 2>&1; then
	echo 'ruby OK'
	echo "use `ruby -v`"
else
	echo 'Error: ruby command must be installed!'
	exit 1
fi


if type bundle > /dev/null 2>&1; then
	echo 'bundler OK'
	echo "use `bundle -v`"
else
	echo "Error: bundler must be installed!"
	echo 'try to run `gem install bundler`'
	exit 1
fi


if type VBoxManage > /dev/null 2>&1; then
	echo 'virtualbox OK'
	echo "use virtualbox version `VBoxManage -v`"
else
	echo "Error: virtualbox must be installed!"
	echo "install from https://www.virtualbox.org"
	exit 1
fi

if type vagrant > /dev/null 2>&1; then
	echo 'vagrant OK'
	echo "use `vagrant -v`"
else
	echo "Error: vagrant must be installed!"
	echo "install from http://www.vagrantup.com"
	exit 1
fi

SCRIPT_DIR=$(cd $(dirname $0); pwd)
INIIALIZED=${SCRIPT_DIR}/.initialized

if [ -f $INIIALIZED ]; then
	echo 'already initialized'
else
	# clone submodules
	git submodule update --init

	pushd src/MAGCruiseBroker
	git submodule update --init
	popd

	# insall vagrant plugin
	vagrant plugin install vagrant-omnibus
	vagrant plugin install vagrant-vbguest
	vagrant plugin install landrush
	vagrant plugin install vagrant-aws
	vagrant plugin install dotenv

	# gem install
	bundle install

	# install vendor cookbooks
	bundle ex berks vendor cookbooks

	touch $INIIALIZED
fi


vagrant up develop
