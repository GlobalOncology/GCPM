(function(App) {

  'use strict';

  var StateModel = Backbone.Model.extend();

  App.Presenter.Categories = function() {
    this.initialize.apply(this, arguments);
  };

  _.extend(App.Presenter.Categories.prototype, {

    defaults: {
      multiple: true,
      name: 'categories',
      label: 'Categories',
      placeholder: 'Select one or more categories',
      blank: true,
      addNew: false,
      select2Options: {
        tags: true
      }
    },

    initialize: function(viewSettings) {
      this.state = new StateModel();
      this.categories = new App.Collection.Categories();
      this.options = _.extend({}, this.defaults, viewSettings || {});
      // Creating view
      this.select = new App.View.Select({
        el: '#categories',
        options: this.options,
        state: this.state
      });

      this.setEvents();
    },

    /**
     * Setting internal events
     */
    setEvents: function() {
      this.state.on('change', function() {
        App.trigger('Categories:change', this.state.attributes);
      }, this);

      this.select.on('change', this.setState, this);
    },

    /**
     * Fetch categories from API
     * @return {Promise}
     */
    fetchData: function() {
      return this.categories.fetch().done(function(r) {
        var options = this.categories.map(function(category) {
          return {
            value: category.attributes.name,
            name: category.attributes.name
          };
        }.bind(this));
        this.select.setOptions(options);
      }.bind(this));
    },

    render: function() {
      this.select.render();

      if (arguments[0]) {
        var state = new StateModel();
        state.set(_.extend({}, this.state.attributes, arguments[0]));
        this.select.setState(state);
      }
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
      this.select.setElement(el);
      this.select.render();
    },

    /**
     * Exposing DOM element
     * @return {DOM}
     */
    getElement: function() {
      return this.select.$el;
    }

  });

})(this.App);
