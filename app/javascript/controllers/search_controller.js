import { Controller } from "stimulus"

export default class extends Controller {
  static values = { url: String }

  search(event) {
    let url = this.urlValue + '?name=' + event.target.value + '&type=search'
    fetch(url, {
      headers: {
        Accept: "text/vnd.turbo-stream.html",
      },
    })
      .then(r => r.text())
      .then(html => Turbo.renderStreamMessage(html))
  }

  disable_enter(event) {
    // enter ile form submitten kaçınmak için
    if (event.keyCode == 13) {
      event.preventDefault();
    }
  }
}