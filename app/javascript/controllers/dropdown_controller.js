import { Controller } from "stimulus"

export default class extends Controller {
  stopPropagation(event) {
    if (!event.target.classList.contains('btn_1')) {
      event.stopPropagation();
    } else {
      this.element.classList.remove('show')
    }
  }

  button_mouseout() {
    if (!this.element.classList.contains('show')) {
      this.element.classList.add('show')
    }
  }
}
