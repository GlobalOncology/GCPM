(function(App) {

  'use strict';

  var StateModel = Backbone.Model.extend({});

  App.Presenter.SubmitEmail = function() {
    this.initialize.apply(this, arguments);
  };

  _.extend(App.Presenter.SubmitEmail.prototype, {

    initialize: function() {
      this.cookie = 'GO_SubmitEmail=1';
      this.state = new StateModel();
      this.view = new App.View.SubmitEmail();
      this.modal = new App.View.Modal({
        className: '-tiny'
      });

      if (!this.getCookie()) {
        this.setCookie();
        this.modal.open(this.view);
      }

      this.setEvents();

    },

    setEvents: function() {
      this.view.on('submit', this.closeModal, this);
    },

    closeModal: function () {
      this.modal.close();
    },

    setCookie: function() {
      var exp = new Date();
      exp.setFullYear(exp.getFullYear() + 10);
      document.cookie = this.cookie + '; expires=' + exp.toUTCString() + '; path=/;';
    },

    getCookie: function () {
      var cookie = document.cookie;
      return (cookie.indexOf(this.cookie) > -1);
    }

  });

})(this.App);
