import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
	static targets = ["button", "count"];

	toggle() {
		const count = parseInt(this.countTarget.textContent, 10);
		const isLiked = this.element.querySelector("img[alt='liked']");

		this.countTarget.textContent = isLiked ? count - 1 : count + 1;
	}
}
