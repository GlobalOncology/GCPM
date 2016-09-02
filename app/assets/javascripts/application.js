// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.

//= require jquery2
//= require jquery_ujs
//= require underscore
//= require backbone
//= require handlebars
//= require leaflet
//= require URIjs

//= require_self

//= require dispatcher
//= require router
//= require layout

//= require_tree ./models
//= require_tree ./collections
//= require_tree ./presenters
//= require_tree ./views
//= require_tree ./controllers
//= require_tree ./facades
// require_tree ./helpers

this.App = {
  facade: {},
  helper: {},
  Model: {},
  Collection: {},
  Controller: {},
  Presenter: {},
  View: {}
};

_.extend(App, Backbone.Events);

/**
 * Dispatcher will be instanced here
 *
 */
function initApp() {
  new App.Dispatcher();
  if (!Backbone.History.started) {
    Backbone.history.start({ pushState: true });
  }
}

document.addEventListener('DOMContentLoaded', initApp)
