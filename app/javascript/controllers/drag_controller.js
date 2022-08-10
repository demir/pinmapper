import { Controller } from "stimulus"
import Sortable from "sortablejs"

export default class extends Controller {
  connect() {
    this.sortable = Sortable.create(this.element, {
      group: 'shared',
      animation: 150,
      onEnd: this.end.bind(this)
    })
  }

  end(event) {
    let pinId = event.item.dataset.id
    let data = new FormData()
    data.append('position', event.newIndex + 1)

    let url = this.data.get('url') + pinId
    fetch(url, {
      method: 'PATCH',
      body: data,
      headers: {
        'X-CSRF-Token': document.head.querySelector("[name='csrf-token']").content
      }
    })
  }
}