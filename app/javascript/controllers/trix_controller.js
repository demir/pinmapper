import { Controller } from 'stimulus'
import Trix from 'trix'

export default class extends Controller {
  connect() {
    this.addEmbedButton()
    this.addEmbedDialog()
    this.eventListenerForEmbedButton()
  }

  //////////////// Embeds ////////////////////////////////////////////////////
  addEmbedButton() {
    const buttonHTML = `<button  type="button" class="trix-button tricks-embed" data-trix-attribute="embed" data-trix-action="embed"    title="${this.element.dataset.embedButtonName}" tabindex="-1">${this.element.dataset.embedButtonName}</button>`
    this.buttonGroupFileTools.insertAdjacentHTML("beforeend", buttonHTML)
  }

  addEmbedDialog() {
    const dialogHTML = `<div class="trix-dialog trix-dialog--embed" data-trix-dialog="embed" data-trix-dialog-attribute="embed" data-tricks-target="embeddialog">
                          <div class='embedder' data-controller="embedder" data-editor-id="${this.element.id}"  class='embedder' data-trix-custom="embedder">
                            <div class="trix-dialog__link-fields">
                              <input type="text" name="embed" class="trix-input trix-input--dialog" placeholder="${this.element.dataset.embedDialogInputPlaceholder}" aria-label="embed code" required="" data-trix-input="" disabled="disabled" data-embedder-target="input" data-sgid-not-found-message="${this.element.dataset.sgidNotFoundMessage}">
                              <div class="trix-button-group">
                                <input type="button" class="trix-button trix-button--dialog" data-trix-custom="add-embed" value="${this.element.dataset.embedDialogAddButton}" data-action="click->embedder#embedit">
                              </div>
                            </div>
                          </div>
                        </div>`
    this.dialogsElement.insertAdjacentHTML("beforeend", dialogHTML)
  }


  showembed(e) {
    const dialog = this.toolbarElement.querySelector('[data-trix-dialog="embed"]')
    const embedInput = this.dialogsElement.querySelector('[name="embed"]')
    if (e.target.classList.contains("trix-active")) {
      e.target.classList.remove("trix-active");
      dialog.classList.remove("trix-active");
      delete dialog.dataset.trixActive;
      embedInput.setAttribute("disabled", "disabled");
    } else {
      e.target.classList.add("trix-active");
      dialog.classList.add("trix-active");
      dialog.dataset.trixActive = "";
      embedInput.removeAttribute("disabled");
      embedInput.focus();
    }
  }

  eventListenerForEmbedButton() {
    this.toolbarElement.querySelector('[data-trix-action="embed"]').addEventListener("click", e => {
      this.showembed(e)
    })
  }

  insertAttachment(content, sgid) {
    const attachment = new Trix.Attachment({ content, sgid })
    this.element.editor.insertAttachment(attachment)
  }

  //////////////// UTILS ////////////////////////////////////////////////////

  get buttonGroupBlockTools() {
    return this.toolbarElement.querySelector("[data-trix-button-group=block-tools]")
  }

  get buttonGroupTextTools() {
    return this.toolbarElement.querySelector("[data-trix-button-group=text-tools]")
  }

  get buttonGroupFileTools() {
    return this.toolbarElement.querySelector("[data-trix-button-group=file-tools]")
  }

  get dialogsElement() {
    return this.toolbarElement.querySelector("[data-trix-dialogs]")
  }

  get toolbarElement() {
    return this.element.toolbarElement
  }
}