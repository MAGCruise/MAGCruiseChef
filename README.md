MAGCruiseChef
=============

## セットアップ

1. Rubyのインストール
2. gemのインストール
	```sh
	bundle install
	```
3. VirtualBoxのインストール
	https://www.virtualbox.org
4. Vagrantのインストール
	http://www.vagrantup.com
5. Vagrant pluginのインストール
	```sh
	vagrant plugin install vagrant-omnibus
	vagrant plugin install vagrant-vbguest
	```

## 使い方

1. cookbooksの取得
	```sh
	bundle ex berks vendor cookbooks
	```

2. Vagrant up


## 更新時
1. gemの更新
	```sh
	bundle install
	```

2. cookbooksの更新
	```sh
	rm -rf cookbooks && bundle ex berks vendor cookbooks
	```

2. provisioningの実行
	```sh
	vagrant provision
	```


## Vagrant box
http://nrel.github.io/vagrant-boxes/
