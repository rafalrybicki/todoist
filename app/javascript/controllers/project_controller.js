import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  colorInput = document.querySelector('#project_color');
  tempColorInput = document.querySelector('#project_temp_color');
  tempColorSVG = document.querySelector('#temp_color_svg');
  colorList = document.querySelector('#color-list');
  submitBtn = document.querySelector('#project-submit-btn');

  toggleColorList(e) {
    if (e.keyCode && e.keyCode !== 13) {
      return
    }

    this.colorList.classList.toggle('open');
  }

  selectColor(e) {
    if (e.keyCode && e.keyCode !== 13) {
      return
    }

    this.colorInput.value = e.target.dataset.colorIndex;
    this.tempColorInput.value = e.target.dataset.colorName;
    this.tempColorSVG.style.color = e.target.dataset.colorValue;

    this.colorList.classList.toggle('open');
  }

  inputChange(e) {
    if (e.target.value === '') {
      this.submitBtn.disabled = true
    } else {
      this.submitBtn.disabled = false
    }
  }

  resetInput() {
    document.querySelector('#project_name').value = '';
  }
}
