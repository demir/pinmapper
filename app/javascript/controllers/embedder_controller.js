import { Controller } from 'stimulus'
import Rails from '@rails/ujs'

export default class extends Controller {
  static targets = ['input']

  embedit(e) {
    e.preventDefault
    let formData = new FormData()
    formData.append('content', this.inputTarget.value)

    Rails.ajax({
      type: 'PATCH',
      url: '/embed/',
      data: formData,
      success: ({ content, sgid }) => {
        if (sgid == '' || sgid == undefined) {
          toastr.warning(this.inputTarget.dataset.sgidNotFoundMessage)
        } else {
          this.editorController().insertAttachment(content, sgid);
        }
      }
    })
  }

  editorController() {
    return this.application.getControllerForElementAndIdentifier(this.editorElement(), 'trix')
  }

  editorElement() {
    return document.querySelector(this.editorElementName())
  }

  editorElementName() {
    return `#${this.finderDiv().dataset.editorId}`
  }

  finderDiv() {
    return this.element.closest('.embedder')
  }
}