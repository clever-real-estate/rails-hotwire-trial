import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "fill",
    "line"
  ]
  toggle() {
    this.lineTarget.classList.toggle("hidden")
    this.fillTarget.classList.toggle("hidden")
  }
}
