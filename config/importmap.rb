# Pin npm packages by running ./bin/importmap
pin "application", preload: true
pin "@hotwired/turbo-rails", to: "@hotwired--turbo-rails.js" # @2.1.0
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
pin "turbo", to: "turbo.min.js", preload: true
pin "bootstrap", to: "https://ga.jspm.io/npm:bootstrap@5.3.5/dist/js/bootstrap.esm.js"
pin "@popperjs/core", to: "https://ga.jspm.io/npm:@popperjs/core@2.11.8/lib/index.js"
pin "bootstrap", to: "https://ga.jspm.io/npm:bootstrap@5.3.5/dist/js/bootstrap.esm.js"
pin "jquery", to: "https://ga.jspm.io/npm:jquery@3.7.1/dist/jquery.js"
pin "jquery", to: "https://ga.jspm.io/npm:jquery@3.7.1/dist/jquery.js"
pin "@rails/ujs", to: "@rails--ujs.js" # @7.1.3
pin "@rails/ujs", to: "rails-ujs.js"
pin "@rails/ujs", to: "https://ga.jspm.io/npm:@rails/ujs@7.0.4/lib/assets/compiled/rails-ujs.js"
