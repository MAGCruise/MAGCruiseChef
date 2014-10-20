# 本番環境(AWS)への配備

1. AWSへアクセスするためのAPIキー等を設定する
    1. .env.sampleをコピーして .env を作成する
    2. AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY に正しい値を設定する
    3. AWS_KEY_PAIR_NAME に使用するキーペアの名前を指定する
    4. AWS_PRIVATE_KEY_PATH にキーペアの秘密鍵のファイルパスを指定する
2. providerをawsとして production を起動する
  ```
  vagrant up production  --provider=aws
  ```

## インスタンスタイプ等のカスタマイズをしたい場合

Vagrantfileを開き、production の定義箇所を以下のように変更する

```ruby
    Aws::configure(production)

    Chef::configure(production, :info) do|chef|
```

↓

```ruby

    Aws::configure(production) do |aws, override|
      aws.instance_type = 'm3.large' # 任意のインスタンスを指定
    end

    Chef::configure(production, :info) do|chef|
```

同様に security_groups, AMI などをカスタマイズできます。他の項目は [mitchellh/vagrant-aws](https://github.com/mitchellh/vagrant-aws) を参照。
