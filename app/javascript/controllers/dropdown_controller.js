import { Controller } from "stimulus"

export default class extends Controller {
  static values = { id: String }

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
        if (input) {
          input.reset();
          let frame = dropdownParent.querySelector('.body > turbo-frame');
          frame.reload();
        }
      }
    }
  }

  updateButton() {
    let dropdown = document.getElementById(this.idValue)
    let dropdownButton = dropdown.querySelector('.add_to_board_btn')
    let removeButtons = dropdown.querySelectorAll('.add-pin-to-board .body .board-list-item-for-pin .remove-button')
    if (removeButtons.length > 0) {
      if (!dropdownButton.classList.contains('added')) {
        dropdownButton.classList.add('added')
      }
    } else {
      if (dropdownButton.classList.contains('added')) {
        dropdownButton.classList.remove('added')
      }
    }
  }
}
