import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  handleSubmit(event) {
    // Optimistic UI: immediately show/hide filled star
    const button = this.element.querySelector('.like-button')
    const isLiked = button.dataset.liked === 'true'
    const starIcon = button.querySelector('.star-icon')

    // Toggle the liked state visually
    if (isLiked) {
      button.classList.remove('liked')
      button.dataset.liked = 'false'
      // Swap star icon temporarily (outline)
      starIcon.src = starIcon.src.replace('star-fill', 'star-line')
    } else {
      button.classList.add('liked')
      button.dataset.liked = 'true'
      // Swap star icon temporarily (filled)
      starIcon.src = starIcon.src.replace('star-line', 'star-fill')
    }
  }
}
