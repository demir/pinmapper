import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ['username']

  connect() {
    this.addTurkishToEnglishPrototype();
  }

  fix_username(event) {
    const regex = /^[a-zA-Z0-9_]*$/g;
    if ((event.data !== null) && (event.data.turkishToEnglish().match(regex) !== null)) {
      this.usernameTarget.value = this.usernameTarget.value.turkishToEnglish().toLocaleLowerCase('en-US');
    } else {
      this.usernameTarget.value = this.usernameTarget.value.slice(0, -1);
    }
  }

  addTurkishToEnglishPrototype() {
    String.prototype.turkishToEnglish = function () {
      return this.replace('Ğ', 'g')
        .replace('Ü', 'u')
        .replace('Ş', 's')
        .replace('I', 'i')
        .replace('İ', 'i')
        .replace('Ö', 'o')
        .replace('Ç', 'c')
        .replace('ğ', 'g')
        .replace('ü', 'u')
        .replace('ş', 's')
        .replace('ı', 'i')
        .replace('ö', 'o')
        .replace('ç', 'c');
    };
  }

}