import { Controller } from "@hotwired/stimulus"

// TaskControllerクラスを定義
export default class extends Controller {
    static targets = ["display", "form", "input"]

    // 接続確認
    connect() {
        this.element.addEventListener("turbo:submit-end", (event) => {
            // 編集モード終了
            this.exitEditMode()
        })
    }

    // 編集モード開始
    edit() {
        this.displayTarget.classList.add("hidden")
        this.formTarget.classList.remove("hidden")
        this.inputTarget.value = this.displayTarget.textContent.trim()
        this.inputTarget.focus()
    }

    // タスク更新
    update() {
        if (this.inputTarget.value.trim() === "") return
        this.formTarget.requestSubmit()
    }

    // 編集モード終了
    exitEditMode() {
        this.displayTarget.classList.remove("hidden")
        this.formTarget.classList.add("hidden")
    }

    // エンターキー押下時の処理
    handleKeypress(event) {
        if (event.key === "Enter") {
            event.preventDefault()
            this.update()
        } else if (event.key === "Escape") {
            // 編集モード終了
            this.exitEditMode()
        }
    }
}