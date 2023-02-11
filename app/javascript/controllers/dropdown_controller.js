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

  scrollFormToUp(event) {
    let frameElement = event.currentTarget
    var parentElement = frameElement.closest('.add-pin-to-board .body')
    let height = frameElement.offsetTop - parentElement.offsetTop - 35
    parentElement.scrollTo({ top: height, behavior: 'smooth' })
  }
}
