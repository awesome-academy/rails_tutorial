import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import "bootstrap"
import jQuery from "jquery"

window.$ = jQuery
window.jQuery = jQuery
Rails.start()   
Turbolinks.start()
ActiveStorage.start()
