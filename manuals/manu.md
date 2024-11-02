# Railsの構築

## 1. 開発環境の準備

### 必要なパッケージのインストール

```bash
sudo apt-get update
sudo apt-get install -y build-essential libssl-dev zlib1g-dev \
  libyaml-dev libreadline-dev libncurses5-dev libffi-dev \
  libgdbm-dev libgdbm-compat-dev bison autoconf ruby-dev
```

### rbenvのインストール

```bash
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
source ~/.bashrc

git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
```

### Rubyのインストール

```bash
rbenv install 3.2.2
rbenv global 3.2.2
```

## 2. Railsプロジェクトの作成

### Railsのインストール

```bash
gem install rails -v 7.1.4
```

### 新規プロジェクトの作成（データベースなし）

```bash
rails new myapp --css=tailwind --skip-active-record
cd myapp
```

### Gemfileの設定

```ruby:Gemfile
source "https://rubygems.org"
ruby "3.2.2"

gem "rails", "7.1.4"
gem "sprockets-rails"
gem "puma"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "tailwindcss-rails"
gem "tzinfo-data", platforms: %i[ windows jruby ]
gem "bootsnap", require: false

group :development do
  gem "web-console"
end
```

### 依存関係のインストール

```bash
bundle install
```

### Hotwireのセットアップ

```bash
bin/rails importmap:install
bin/rails turbo:install stimulus:install
bin/rails tailwindcss:install
```

## 3. 開発サーバーの起動

### foremanのインストール
```bash
gem install foreman
```

### サーバーの起動方法（2つの選択肢）

#### foremanを使用

```bash
bin/dev
```

## 4. 動作確認

ブラウザで以下のURLにアクセス：
```
http://localhost:3000
```
