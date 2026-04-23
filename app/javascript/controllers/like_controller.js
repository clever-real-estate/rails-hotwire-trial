// app/javascript/controllers/like_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["icon"]

  toggle() {
    this.iconTarget.classList.toggle("liked")
  }
}
