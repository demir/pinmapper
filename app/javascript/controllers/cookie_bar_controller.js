import { Controller } from 'stimulus'

export default class extends Controller {
  allowCookies(event) {
    Cookies.set('allow_cookies', 'yes', {
      expires: 365
    });
  }
}