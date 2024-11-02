# アプリケーションの設定を管理するモジュール
module AppConfig
    class << self
      def twitter_url
        ENV['TWITTER_URL']
      end
  
      def github_url
        ENV['GITHUB_URL']
      end
    end
  end