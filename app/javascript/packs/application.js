import Rails from "@rails/ujs";
import * as ActiveStorage from "@rails/activestorage";
import "channels";

import $ from 'jquery';
window.$ = $;

Rails.start();
ActiveStorage.start();

import { Turbo } from "@hotwired/turbo-rails"
Turbo.start();

document.addEventListener("turbo:load", function() {
});
