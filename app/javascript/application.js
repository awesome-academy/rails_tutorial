// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "bootstrap"
import "jquery"
import "./javascript"
import Rails from "@rails/ujs"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
Rails.start();
ActiveStorage.start()
document.addEventListener("turbo:load", () => {
  Rails.confirm = (message) => {
    return confirm(message);
  };
});
