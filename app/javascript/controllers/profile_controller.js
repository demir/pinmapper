import { Controller } from 'stimulus'

export default class extends Controller {
  static values = { mouseoverText: String, mouseoutText: String }

  unfollow_button_mouseover(event) {
    this.element.innerHTML = this.mouseoverTextValue
  }

  unfollow_button_mouseout(event) {
    this.element.innerHTML = this.mouseoutTextValue
  }
}