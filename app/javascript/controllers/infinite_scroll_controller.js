import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["scrollArea"]
  static values = { nextPage: String, nextPageUrl: String }

  connect() {
    this.createObserver()
  }
  createObserver() {
    const observer = new IntersectionObserver(
      entries => this.handleIntersect(entries),
      {
        // https://github.com/w3c/IntersectionObserver/issues/124#issuecomment-476026505
        threshold: [0, 1.0],
      }
    )
    observer.observe(this.scrollAreaTarget)
  }
  handleIntersect(entries) {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        this.loadMore()
      }
    })
  }
  loadMore() {
    const nextPage = this.nextPageValue
    const nextPageUrl = this.nextPageUrlValue
    if (!nextPage || !nextPageUrl) {
      return
    }
    fetch(nextPageUrl, {
      headers: {
        Accept: "text/vnd.turbo-stream.html",
      },
    })
      .then(r => r.text())
      .then(html => Turbo.renderStreamMessage(html))
  }
}