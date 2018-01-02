/* global ga */
(function(App) {

  'use strict';

  App.View.SubmitEmail = Backbone.View.extend({

    template: HandlebarsTemplates['submit_email'],

    events: {
      'submit form': 'handleSubmit'
    },

    initialize: function() {
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

  });

})(this.App);
