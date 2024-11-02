import { Controller } from "@hotwired/stimulus"

// TaskControllerクラスを定義
export default class extends Controller {
    static targets = ["display", "form", "input"]

    // 編集アイコンクリックで編集モードに切り替え
    edit() {
        this.displayTarget.classList.add("hidden")
        this.formTarget.classList.remove("hidden")
        this.inputTarget.value = this.displayTarget.textContent.trim()
        this.inputTarget.focus()
    }

    // フォーカスが外れたら更新
    update() {
        if (this.inputTarget.value.trim() === "") return
        this.formTarget.requestSubmit()
    }

    // キー入力の処理
    handleKeypress(event) {
        if (event.key === "Enter") {
            event.preventDefault()
            this.update()
        } else if (event.key === "Escape") {
            this.cancel()
        }
    }

    // 編集をキャンセル
    cancel() {
        this.displayTarget.classList.remove("hidden")
        this.formTarget.classList.add("hidden")
    }
}