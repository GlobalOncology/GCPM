(function(App) {

  'use strict';

  var StateModel = Backbone.Model.extend();

  App.Presenter.PickadateEnd = function() {
    this.initialize.apply(this, arguments);
  };

  _.extend(App.Presenter.PickadateEnd.prototype, {

    defaults: {
      name: 'end_date',
      label: 'End date',
      min: new Date(1905,1,1),
      max: new Date(2040,1,1)
    },

    initialize: function(viewSettings) {
      this.state = new StateModel();

      // Creating view
      this.pickadate = new App.View.PickadateNew({
        el: '#pickadate-end',
        options: _.extend({}, this.defaults, viewSettings || {}),
        state: this.state
      });

      this.setEvents();
    },

    /**
     * Setting internal events
     */
    setEvents: function() {
      this.state.on('change', function() {
        App.trigger('PickadateEnd:change', this.state.attributes);
      }, this);

      App.on('PickadateStart:change', function(state) {
        this.pickadate.$datePicker.set('min', new Date(state.value));
      }.bind(this));

      this.pickadate.on('change', this.setState, this);
    },

    /**
     * Fetch cancer types from API
     * @return {Promise}
     */
    render: function() {
      this.pickadate.render();
    },

    /**
     * Method to set a new state
     * @param {Object} state
     */
    setState: function(state, options) {
      this.state.set(state, options);
    },

    /**
     * Rebinding element, events and render again
     * @param {DOM|String} el
     */
    setElement: function(el) {
      this.pickadate.setElement(el);
    },

    /**
     * Exposing DOM element
     * @return {DOM}
     */
    getElement: function() {
      return this.pickadate.$el;
    }

  });

})(this.App);
