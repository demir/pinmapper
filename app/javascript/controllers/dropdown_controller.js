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
      let dropdown = dropdownParent.querySelector('.add-pin-to-board')
      if (dropdown.classList.contains('show')) {
        dropdown.classList.remove('show');
        this.toggle_added(dropdownParent);
      }
    }
  }

  toggle_added(dropdownParent) {
    let dropdownButton = dropdownParent.querySelector('.add_to_board_btn')
    let dropdownMenu = dropdownParent.querySelector('.add-pin-to-board')
    let removeButtons = dropdownMenu.querySelectorAll('.body .board-list-item-for-pin .remove-button')
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
