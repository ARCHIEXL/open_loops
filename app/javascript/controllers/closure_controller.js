import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { taskId: Number, intent: String }

  remember() {
    if (this.intentValue === "close") {
      sessionStorage.setItem("ol_just_closed", String(this.taskIdValue))
    }
  }
}
