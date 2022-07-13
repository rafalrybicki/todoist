import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  resetContent() {
    document.querySelector('#task_content').value = '';
  }
}
