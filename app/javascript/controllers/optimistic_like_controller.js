import { Controller } from "@hotwired/stimulus"

// Optimistic-UI for the like button:
//   1. On click, flip the star + count immediately so it feels instant.
//   2. Let the form submit normally; the Turbo Stream response replaces this
//      element with the server-confirmed state.
//   3. If the request fails, revert.
//
// SVG paths are kept here as constants so we don't need an extra HTTP round-trip
// to swap them.
const STAR_FILL = `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" width="18" height="18" aria-hidden="true"><path d="M12.0006 18.26L4.94715 22.2082L6.52248 14.2799L0.587891 8.7918L8.61493 7.84006L12.0006 0.5L15.3862 7.84006L23.4132 8.7918L17.4787 14.2799L19.054 22.2082L12.0006 18.26Z"/></svg>`
const STAR_LINE = `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" width="18" height="18" aria-hidden="true"><path d="M12.0006 18.26L4.94715 22.2082L6.52248 14.2799L0.587891 8.7918L8.61493 7.84006L12.0006 0.5L15.3862 7.84006L23.4132 8.7918L17.4787 14.2799L19.054 22.2082L12.0006 18.26ZM12.0006 15.968L16.2473 18.3451L15.2988 13.5717L18.8719 10.2674L14.039 9.69434L12.0006 5.27502L9.96214 9.69434L5.12921 10.2674L8.70231 13.5717L7.75383 18.3451L12.0006 15.968Z"/></svg>`

export default class extends Controller {
  static targets = ["icon", "count"]
  static values  = { liked: Boolean, count: Number }

  connect() {
    this.form = this.element.querySelector("form")
    if (this.form) {
      this.form.addEventListener("submit", this.optimisticToggle)
      this.form.addEventListener("turbo:submit-end", this.handleResult)
    }
  }

  disconnect() {
    if (this.form) {
      this.form.removeEventListener("submit", this.optimisticToggle)
      this.form.removeEventListener("turbo:submit-end", this.handleResult)
    }
  }

  optimisticToggle = () => {
    this._previousLiked = this.likedValue
    this._previousCount = this.countValue

    const nextLiked = !this.likedValue
    const nextCount = nextLiked ? this.countValue + 1 : Math.max(0, this.countValue - 1)

    this._applyState(nextLiked, nextCount)
  }

  handleResult = (event) => {
    if (event.detail && event.detail.success === false) {
      this._applyState(this._previousLiked, this._previousCount)
    }
    // On success, the server response replaces this element entirely, so no
    // further action is needed — the new element re-connects with fresh state.
  }

  _applyState(liked, count) {
    this.likedValue = liked
    this.countValue = count
    if (this.hasIconTarget)  this.iconTarget.innerHTML = liked ? STAR_FILL : STAR_LINE
    if (this.hasCountTarget) this.countTarget.textContent = count

    const button = this.element.querySelector(".like")
    if (button) {
      button.setAttribute("aria-pressed", liked ? "true" : "false")
      button.setAttribute("aria-label",
        liked ? `Unlike photo` : `Like photo`)
    }
  }
}
