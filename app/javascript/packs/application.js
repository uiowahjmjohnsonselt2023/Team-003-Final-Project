import Rails from "@rails/ujs";
Rails.start();

import $ from 'jquery';
window.$ = $;

ActiveStorage.start();

import { Turbo } from "@hotwired/turbo-rails"
Turbo.start();

document.addEventListener("turbo:load", function() {
});
