import { Controller } from "stimulus"

export default class extends Controller {
  stopPropagation(event) {
    event.stopPropagation();
  }
}
