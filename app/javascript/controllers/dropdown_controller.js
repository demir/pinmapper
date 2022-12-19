import { Controller } from "stimulus"

export default class extends Controller {
  static values = { id: String }

  switchBoardsPanel(event) {
    let frameElement = event.currentTarget
    var parentElement = frameElement.closest('.add-pin-to-board')
    parentElement.querySelector('#add-pin-to-board-panel-board').classList.toggle('visually-hidden')
    parentElement.querySelector('#add-pin-to-board-panel-section').classList.toggle('visually-hidden')
  }

  hide() {
    let dropdowns = this.element.getElementsByClassName('add-pin-to-board-dropdown');
    for (let dropdownParent of dropdowns) {
      let dropdown = dropdownParent.querySelector('.add-pin-to-board');
      dropdown.querySelector('#add-pin-to-board-panel-board').classList.remove('visually-hidden')
      dropdown.querySelector('#add-pin-to-board-panel-section').classList.add('visually-hidden')
      dropdownParent.querySelector('.body').scrollTop = 0;
      if (dropdown.classList.contains('show')) {
        dropdown.classList.remove('show');
        let forms = dropdownParent.getElementsByClassName('form');
        for (let form of forms) {
          form.reset();
          form.querySelector('#name').dispatchEvent(new Event('input'));
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

  scrollFormToUp(event) {
    let frameElement = event.currentTarget
    var parentElement = frameElement.closest('.add-pin-to-board .body')
    let height = frameElement.offsetTop - parentElement.offsetTop - 35
    parentElement.scrollTo({ top: height, behavior: 'smooth' })
  }
}
