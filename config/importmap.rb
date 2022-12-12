# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"

if Rails.env.development?
  pin "vue", to: "vue--dist--vue.esm-browser.js.js" # @3.2.45
else
  pin "vue", to: "vue--dist--vue.esm-browser.prod.js.js" # @3.2.45
end