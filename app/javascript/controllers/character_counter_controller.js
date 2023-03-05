import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ['input', 'counter']
  static values = { countdown: Boolean }

  initialize() {
    this.update = this.update.bind(this)
  }

  connect() {
    this.update(), this.inputTarget.addEventListener('input', this.update)
  }

  disconnect() {
    this.inputTarget.removeEventListener('input', this.update)
  }

  update() {
    this.counterTarget.innerHTML = this.count.toString()
  }

  get count() {
    let t = this.inputTarget.value.length;
    return this.hasCountdownValue && (this.maxLength < 0 && console.error(`[stimulus-character-counter] You need to add a maxlength attribute on the input to use countdown mode. The current value is: ${this.maxLength}.`), t = Math.max(this.maxLength - t, 0)), t
  }

  get maxLength() {
    return this.inputTarget.maxLength
  }
}
