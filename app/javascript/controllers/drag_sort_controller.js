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
    let data = new FormData()
    data.append('position', event.newIndex + 1)

    let sortUrl = event.item.dataset.sortUrl
    if (sortUrl) {
      fetch(sortUrl, {
        method: 'PATCH',
        body: data,
        headers: {
          'X-CSRF-Token': document.head.querySelector("[name='csrf-token']").content
        }
      })
    }
  }
}