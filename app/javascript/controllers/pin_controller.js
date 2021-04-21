import { Controller } from "stimulus"

export default class extends Controller {
  liked(e) {
    e.preventDefault();
    e.currentTarget.classList.toggle('liked');
  }
}
