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
        this.openModal();
      }

      this.setEvents();

    },

    setEvents: function() {
      this.view.on('submit', this.submit, this);
      this.view.on('showSignup', this.openModal, this);
    },

    submit: function () {
      this.closeModal();
      document.location.href = '/users/sign_up?src=homepage'
    },

    openModal: function () {
      this.modal.open(this.view);
      $.getScript('//s3.amazonaws.com/downloads.mailchimp.com/js/mc-validate.js', function() {
        window.fnames = new Array(); window.ftypes = new Array();
        fnames[0]='EMAIL';ftypes[0]='email';fnames[1]='FNAME';
        ftypes[1]='text';fnames[2]='LNAME';ftypes[2]='text';
        fnames[3]='MMERGE3';ftypes[3]='text';fnames[4]='MMERGE4';
        ftypes[4]='text';fnames[5]='MMERGE5';ftypes[5]='text';

        window.$mcj = jQuery.noConflict(true);

        window.mc.ajaxOptions.success = function(resp) {
          window.mc.mce_success_cb(resp);
          if (resp.result === "success") {
            this.submit();
          }
        }.bind(this);

      }.bind(this));
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
