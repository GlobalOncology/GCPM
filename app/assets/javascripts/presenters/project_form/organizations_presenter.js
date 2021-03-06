(function(App) {

  'use strict';

  var StateModel = Backbone.Model.extend();

  App.Presenter.Organizations = function() {
    this.initialize.apply(this, arguments);
  };

  _.extend(App.Presenter.Organizations.prototype, {

    defaults: {
      multiple: true,
      name: 'organizations[]',
      label: 'Organizations',
      placeholder: 'All organizations',
      blank: null,
      addNew: true,
      select2Options: {
      }
    },

    initialize: function(viewSettings) {
      this.state = new StateModel();
      this.organizations = new App.Collection.Organizations();
      this.options = _.extend({}, this.defaults, viewSettings || {});

      // Creating view
      this.select = new App.View.Select({
        el: '#organizations',
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
        App.trigger('Organizations:change', this.state.attributes);
      }, this);

      this.select.on('setValues', function(values){
        this.setValues(values);
      }, this);

      this.select.on('change', this.setState, this);
    },

    /**
     * Fetch cancer types from API
     * @return {Promise}
     */
    fetchData: function() {
      return true;
      // return this.organizations.fetch().done(function() {
      //   var options = this.organizations.map(function(type) {
      //     return {
      //       text: type.attributes.name,
      //       id: type.attributes.id
      //     };
      //   });
      //   this.select.setOptions(options);
      // }.bind(this));
    },

    render: function() {
      this.select.render();
    },

    setValues: function(values) {
      _.each(values, function(v){
        if (v) {
          this.organizationModel = new App.Model.Organization({
            id: v
          });
          this.organizationModel.fetch().done(function(model){
            $(this.select.select.selector).select2("trigger", "select", {
              data: {
                id: model.id,
                text: model.name
              }
            });
          }.bind(this));
        }
        // var current = _.findWhere(this.options.options, { id: parseInt(v) }) || _.findWhere(this.options.options, { value: parseInt(v) });
      }.bind(this));
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
