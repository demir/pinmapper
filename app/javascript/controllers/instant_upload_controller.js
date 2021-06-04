import { Controller } from "stimulus"
import { DirectUpload } from "@rails/activestorage"

export default class extends Controller {
  static targets = ["input", "image"]

  event() {
    if (this._event == undefined) {
      this._event = document.createEvent("CustomEvent")
      this._event.initCustomEvent("instant-uploaded", true, true, null)
    }
    return this._event
  }

  changed() {
    Array.from(this.inputTarget.files).forEach(file => {
      const upload = new DirectUpload(file, this.postURL())
      upload.create((error, blob) => {
        this.hiddenInput().value = blob.signed_id
        this.inputTarget.type = "hidden"
        this.imageTarget.src = `${this.getURL()}/${blob.signed_id}/${blob.filename}`
        this.imageTarget.dispatchEvent(this.event())
      })
    })
  }

  hiddenInput() {
    if (this._hiddenInput == undefined) {
      this._hiddenInput = document.createElement('input')
      this._hiddenInput.name = this.inputTarget.name
      this._hiddenInput.type = "hidden"
      this.inputTarget.parentNode.insertBefore(this._hiddenInput, this.inputTarget.nextSibling)
    }
    return this._hiddenInput
  }

  postURL() {
    return '/rails/active_storage/direct_uploads'
  }

  getURL() {
    return '/rails/active_storage/blobs/redirect'
  }
}