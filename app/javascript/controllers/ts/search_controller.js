import { Controller } from "@hotwired/stimulus"
import { get } from '@rails/request.js'
import TomSelect from "tom-select"

export default class extends Controller {
  static values = { url: String }

  connect() {
    if (this.element.classList.contains('tomselected')) return;

    let _this = this;
    var config = {
      plugins: ['clear_button'],
      valueField: 'value',
      onInitialize: function () {
        _this.setOptions(this)
      }
    }

    new TomSelect(this.element, config)
  }

  async setOptions(control) {
    const response = await get(this.urlValue, { responseKind: 'json' })
    if (response.ok) {
      const options = await response.json
      control.addOptions(options)
    }
  }
}