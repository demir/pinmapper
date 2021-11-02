import { Controller } from 'stimulus'

export default class extends Controller {
  static values = { mouseoverText: String, mouseoutText: String }

  button_mouseover(event) {
    this.element.innerHTML = this.mouseoverTextValue
  }

  button_mouseout(event) {
    this.element.innerHTML = this.mouseoutTextValue
  }
}