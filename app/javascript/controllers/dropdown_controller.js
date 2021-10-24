import { Controller } from "stimulus"

export default class extends Controller {
  stopPropagation(event) {
    if (!event.target.classList.contains('btn_1')) {
      event.stopPropagation();
    } else {
      this.element.classList.remove('show')
    }
  }

  hide() {
    let dropdowns = this.element.getElementsByClassName('add-pin-to-board-dropdown');
    for (let dropdownParent of dropdowns) {
      let dropdown = dropdownParent.querySelector('.add-pin-to-board');
      dropdownParent.querySelector('.body').scrollTop = 0;
      if (dropdown.classList.contains('show')) {
        dropdown.classList.remove('show');
        let input = dropdownParent.querySelector('form');
        input.reset();
        let frame = dropdownParent.querySelector('.body > turbo-frame');
        frame.reload();
      }
    }
  }
}
