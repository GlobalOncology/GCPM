/* global ga */
(function(App) {

  'use strict';

  App.View.SubmitEmail = Backbone.View.extend({

    template: HandlebarsTemplates['submit_email'],

    events: {
      'submit form': 'handleSubmit'
    },

    initialize: function() {
      $('.newsletter-signup-link').on('click', this.showSignup.bind(this));
    },

    render: function() {
      this.$el.html(this.template);

      // Rebinding elements and events
      this.delegateEvents();

      return this;
    },

    handleSubmit: function() {
      this.trigger('submit');
    },

    showSignup: function() {
      this.trigger('showSignup');
      return false;
    }

  });

})(this.App);
