# MAGCruiseChef
=============

## セットアップ手順書

開発開始前に実行する

1. Ruby 及び Rubygems のインストール
	Version 2.0 以降を推奨
2. bundler をインストール
	```ruby
	gem install bundler
	```
3. VirtualBoxのインストール
	サイトからパッケージをダウンロードしてインストール
	https://www.virtualbox.org
4. Vagrantのインストール
	http://www.vagrantup.com
	サイトからパッケージをダウンロードしてインストール
5. setup.sh を実行
	```sh
	sh setup.sh
	```

## 更新時
リポジトリが更新された場合に実行する

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

## 動作確認
ブラウザから [http://www.magcruise.dev/](http://www.magcruise.dev/) にアクセス

データベース
: WebUI webui.magcruise.dev
:	ホスト db.magcruise.dev
: Broker broker.magcruise.dev

IPアドレスは Vagrantfileを参照

## Vagrant box
http://nrel.github.io/vagrant-boxes/
