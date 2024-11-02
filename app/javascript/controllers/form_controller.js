import { Controller } from "@hotwired/stimulus"

// FormControllerクラスを定義
export default class extends Controller {
    static targets = ["input"] // inputターゲットを定義

    connect() {
        // フォーム送信完了時のイベントリスナー
        this.element.addEventListener("turbo:submit-end", () => {
            this.inputTarget.value = "" // フォームの内容をクリア
        })
    }

    submitOnEnter(event) {
        if (event.key === "Enter") { // Enterキーが押された場合
            event.preventDefault() // デフォルトの動作を防ぐ
            this.element.requestSubmit() // フォームを送信
        }
    }
}