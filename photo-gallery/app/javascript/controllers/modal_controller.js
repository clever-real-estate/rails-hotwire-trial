import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["dialog", "image"]

  open(event) {
    const card = event.currentTarget
    this.imageTarget.src = card.dataset.modalSrc
    this.imageTarget.alt = card.dataset.modalAlt || ""
    this.dialogTarget.showModal()
  }

  close() {
    this.dialogTarget.close()
    this.imageTarget.src = ""
  }

  closeOnBackdrop(event) {
    if (event.target === this.dialogTarget) this.close()
  }
}
