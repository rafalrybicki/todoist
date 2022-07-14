import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  taskSubmitBtn = document.querySelector('#task-submit-btn');

  inputChange(e) {
    if (e.target.value === '') {
      this.taskSubmitBtn.disabled = true
    } else {
      this.taskSubmitBtn.disabled = false
    }
  }

  resetContent() {
    document.querySelector('#task_content').value = '';
  }
}
