# Hotwireについて

Hotwireは、モダンなWeb開発をシンプルに実現するためのアプローチ。
主に以下の3つの技術で構成されています：

- Turbo (Frames, Streams)
- Stimulus (JavaScript)
- Strada (モバイル連携)

## Turbo Framesとは

ページの一部分を独立した更新可能な領域として定義する機能
サーバーサイドレンダリングの利点を生かしつつ、ページの一部分だけを更新できる

```erb:_task.html.erb
<%= turbo_frame_tag dom_id(task) do %>
  <li class="flex items-center">
    <%= task.text %>
  </li>
<% end %>
```

### メリット
- 必要な部分だけを更新（パフォーマンス向上）
- スクロール位置やフォーカスが維持される
- JavaScriptを書かずに実現可能

## Turbo Streamsとは

ページの一部分を更新するためのメカニズム。
複数の要素を一度に更新したり、要素の追加・削除などが可能です。

```rb:tasks_controller.rb
def create
  @task = Task.new(task_params)
  
  if @task.save
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.append("tasks", partial: "tasks/task", locals: { task: @task })
      end
    end
  end
end

def update
  @task = Task.find(params[:id])
  
  if @task.update(task_params)
    respond_to do |format|
      format.turbo_stream do
          render turbo_stream: turbo_stream.replace(@task, partial: "tasks/task", locals: { task: @task })
      end
    end
  end
end
```

### 主な操作
- append: 要素を追加
- prepend: 要素を先頭に追加
- replace: 要素を置き換え
- remove: 要素を削除
- update: 要素を更新

## Stimulusとは

シンプルなJavaScriptフレームワークです。
HTMLとJavaScriptを結びつけるための規約を提供します。

```javascript:form_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input"]

  connect() {
    this.element.addEventListener("turbo:submit-end", () => {
      this.inputTarget.value = ""  // フォーム送信後にクリア
    })
  }
}
```

```erb:index.html.erb
<%= form_with(model: Task.new, data: { controller: "form" }) do |f| %>
  <%= f.text_field :text, data: { form_target: "input" } %>
<% end %>
```

## 従来のAjaxとの比較

### 従来のやり方（jQuery/Ajax）
```javascript
$.ajax({
  url: '/tasks',
  method: 'POST',
  data: { task: { text: text } },
  success: function(response) {
    $('#tasks').append(response);
  }
});
```

### Hotwireのやり方
```ruby
# Controller
format.turbo_stream

# View (create.turbo_stream.erb)
<%= turbo_stream.append "tasks", partial: "tasks/task" %>
```

### メリット
1. シンプルな実装
   - カスタムJavaScriptが最小限
   - サーバーサイドの知識だけで実装可能
2. 保守性の向上
   - コードの見通しが良い
   - フレームワークの規約に従った実装
3. パフォーマンス
   - 必要な部分だけを更新
   - ページ全体の再読み込みを回避