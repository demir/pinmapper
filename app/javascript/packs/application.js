function importAll(r) {
  r.keys().forEach(r);
}

import Rails from "@rails/ujs"
import "@hotwired/turbo-rails"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
ActiveStorage.start()

import "controllers"
import "bootstrap"

// import styles
import "../styles/main.scss"

import "../styles/fonts/fonts.scss"
require("@fortawesome/fontawesome-free/js/all")

importAll(require.context('../src', true, /\.js(\.erb)?$/))
require.context('../images', true)