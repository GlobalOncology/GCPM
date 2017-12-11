(function(App) {

  'use strict';

  var StateModel = Backbone.Model.extend();

  App.Presenter.OrganizationAcronym = function() {
    this.initialize.apply(this, arguments);
  };

  _.extend(App.Presenter.OrganizationAcronym.prototype, {

    defaults: {
      name: 'title'
    },

    initialize: function() {
      this.state = new StateModel();
      this.Input = new App.View.Input({
        el: '#organizationacronym',
        options: {
          label: 'Organization Acronym',
          placeholder: 'Organization Acronym',
          name: 'organizationAcronym',
          type: 'text',
          class: 'c-input'
        }
      });

      this.setEvents();
    },

    setEvents: function(){
      this.state.on('change', function(){
        App.trigger('Input:change', this.state.attributes);
      }, this);

      this.Input.on('change', this.setState, this);
    },

    render: function(){
      this.Input.render();
    },

    setState: function(state, options) {
      this.state.set(state, options);
    },

    setElement: function(el) {
      this.Input.setElement(el);
    },

    getElement: function() {
      return this.Input.$el;
    }

  });

})(this.App);
