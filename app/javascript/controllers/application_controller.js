import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  menu = document.querySelector('#menu');

  watchBodyWidth(e) {
    if (e.target.innerWidth <= 576) {
      this.menu.classList.remove('open');
    }
  }

  toggleMenu() {
    this.menu.classList.toggle('open');
  }
}
