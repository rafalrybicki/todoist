import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  // taskForm = document.getElementById('task-form');
  taskSubmitBtn = document.getElementById('task-submit-btn');
  dataset = document.getElementById('task-form').dataset;

  inputChange(e) {
    const value = e.target.value;
    this.dataset.currentContent = value;

    this.handleSubmitBtn();
  }

  togglePickerBody() {
    document.getElementById('date-picker-body').classList.toggle('show');
  }

  selectDate(e) {
    const selectedDate = e.target.dataset.date;
    this.dataset.currentDate = selectedDate;

    document.getElementById('task_target_date').value = selectedDate;

    this.handleSubmitBtn();
  }

  handleSubmitBtn() {
    if (this.isContentEmpty() || this.isValid()) {
      this.taskSubmitBtn.disabled = true;
    } else {
      this.taskSubmitBtn.disabled = false;
    }
  }

  resetContent() {
    document.getElementById('task_content').value = '';
  }

  private

  isContentEmpty() {
    return !this.dataset.currentContent;
  }

  isValid() {
    const prevContentIsEqualToCurrentContent = this.dataset.prevContent === this.dataset.currentContent;
    let prevDateIsEqualToCurrentDate;

    if (this.dataset.prevDate) {
      prevDateIsEqualToCurrentDate = this.dataset.prevDate === this.dataset.currentDate;
    } else {
      prevDateIsEqualToCurrentDate = !this.dataset.currentDate;
    }
    return prevContentIsEqualToCurrentContent && prevDateIsEqualToCurrentDate
  }
}
