import { Controller } from 'stimulus'
import Trix from 'trix'

addHeadingAttributes()
export default class extends Controller {
  connect() {
    this.addEmbedButton()
    this.addEmbedDialog()
    this.eventListenerForEmbedButton()

    this.insertHeadingElements()
  }

  //////////////// Embeds ////////////////////////////////////////////////////

  addEmbedButton() {
    const buttonHTML = `<button  type="button" id="trix-embed-button" class="trix-button tricks-embed" data-trix-attribute="embed" data-trix-action="embed"    title="${this.element.dataset.embedButtonName}" tabindex="-1">${this.element.dataset.embedButtonName}</button>`
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

  //////////////// Headers ////////////////////////////////////////////////////

  insertHeadingElements() {
    this.removeOriginalHeadingButton()
    this.insertNewHeadingButton()
    this.insertHeadingDialog()
  }
  removeOriginalHeadingButton() {
    this.buttonGroupBlockTools.removeChild(this.originalHeadingButton)
  }

  insertNewHeadingButton() {
    this.buttonGroupBlockTools.insertAdjacentHTML("afterbegin", this.headingButtonTemplate)
  }

  insertHeadingDialog() {
    this.dialogsElement.insertAdjacentHTML("beforeend", this.dialogHeadingTemplate)
  }

  get dialogHeadingTemplate() {
    return `
      <div class="trix-dialog trix-dialog--heading" data-trix-dialog="x-heading" data-trix-dialog-attribute="x-heading">
        <div class="trix-dialog__link-fields">
          <div class="trix-button-group">
            <button type="button" class="trix-button trix-button--dialog" data-trix-attribute="heading2">H2</button>
            <button type="button" class="trix-button trix-button--dialog" data-trix-attribute="heading3">H3</button>
            <button type="button" class="trix-button trix-button--dialog" data-trix-attribute="heading4">H4</button>
            <button type="button" class="trix-button trix-button--dialog" data-trix-attribute="heading5">H5</button>
            <button type="button" class="trix-button trix-button--dialog" data-trix-attribute="heading6">H6</button>
          </div>
        </div>
      </div>
    `
  }

  get headingButtonTemplate() {
    return '<button type="button" class="trix-button trix-button--icon trix-button--icon-heading-1" data-trix-action="x-heading" title="Heading" tabindex="-1">Heading</button>'
  }

  get originalHeadingButton() {
    return this.toolbarElement.querySelector("[data-trix-attribute=heading1]")
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

function addHeadingAttributes() {
  Array.from(["h2", "h3", "h4", "h5", "h6"]).forEach((tagName, i) => {
    Trix.config.blockAttributes[`heading${(i + 2)}`] = { tagName: tagName, terminal: true, breakOnReturn: true, group: false }
  })
  Trix.config.attachments = {
    preview: {
      presentation: "gallery",
      thing: 'my-thing',
      caption: {
        name: true,
        size: true
      }
    },
    file: {
      caption: {
        size: true
      }
    }
  };
}