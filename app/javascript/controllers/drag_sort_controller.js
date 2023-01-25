import { Controller } from "stimulus"
import Sortable from "sortablejs"

export default class extends Controller {
  static values = { state: Boolean }

  connect() {
    if (!this.stateValue) {
      return
    }

    this.sortable = Sortable.create(this.element, {
      group: this.element,
      animation: 150,
      delay: 200,
      delayOnTouchOnly: true,
      onEnd: this.end.bind(this)
    })
  }

  end(event) {
    let data = new FormData()
    data.append('position', event.newIndex + 1)

    if (!event.item.dataset.sortUrl) {
      return
    }

    fetch(event.item.dataset.sortUrl, {
      method: 'PATCH',
      body: data,
      headers: {
        'X-CSRF-Token': document.head.querySelector("[name='csrf-token']").content
      }
    })
  }
}