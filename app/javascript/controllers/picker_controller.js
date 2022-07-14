import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  togglePickerBody(e) {
    document.getElementById(e.target.dataset.target).classList.toggle('show');
  }
}
