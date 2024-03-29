import { Controller } from 'stimulus'

export default class extends Controller {
  allowCookies(event) {
    let cookiesBar = document.getElementById("cookies-bar");
    cookiesBar.style.display = "none";
    Cookies.set('allow_cookies', 'yes', {
      expires: 365
    });
  }
}