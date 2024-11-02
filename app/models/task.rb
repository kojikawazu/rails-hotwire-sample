# タスクモデル
class Task
    # ActiveModelの機能を取り込んで、DBなしでモデルのような振る舞いを実現
    include ActiveModel::Model
    include ActiveModel::Attributes
    
    # モデルの属性を定義
    attribute :id, :integer
    attribute :text, :string
    attribute :completed, :boolean, default: false
    
    # インメモリでデータを保持するためのクラス変数
    @@tasks = []
    @@next_id = 1
    
    # すべてのタスクを取得
    def self.all
      @@tasks
    end

    # ActiveModelのインターフェースに必要なメソッド
    # レコードが永続化されているかどうかを確認（idの有無で判断）
    def persisted?
      id.present?
    end

    # タスクが完了しているかどうかを確認
    # completedがtrueの場合にtrueを返す
    def completed?
      completed == true
    end
    
    # タスクの保存
    def save
      # タスクの内容が空の場合は保存しない
      return false if text.blank?

      # 新しいIDを割り当てて配列に追加
      self.id = @@next_id
      @@next_id += 1
      @@tasks << self
      true
    end
    
    # タスクの属性を更新
    def update(attributes)
      attributes.each do |key, value|
        send("#{key}=", value) # 各属性をセット
      end
      true
    end
    
    # タスクを削除
    def destroy
      @@tasks.delete(self) # 配列からタスクを削除
      true
    end
    
    # IDを指定してタスクを検索
    def self.find(id)
      @@tasks.find { |task| task.id == id.to_i }
    end
end