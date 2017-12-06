(function(App) {

  'use strict';

  var StateModel = Backbone.Model.extend({});

  App.Presenter.OrganizationAddressForm = function() {
    this.initialize.apply(this, arguments);
  };

  _.extend(App.Presenter.OrganizationAddressForm.prototype, {

    initialize: function(params) {
      this.state = new StateModel(params);
      this.DOMelementId = params.DOMelementId;

      var organizationCountry = new App.Presenter.OrganizationCountry();
      var organizationLatitude = new App.Presenter.OrganizationLatitude({});
      var organizationLongitude = new App.Presenter.OrganizationLongitude();
      var organizationCity = new App.Presenter.OrganizationCity();

      this.mapSearch = new App.View.MapSearch({
        el: '#map-search',
        options: {
          nocreate: true
        }
      });

      this.map = new App.View.Map({
        el: '#map',
        options: {
          nocreate: true,
          zoom: 3,
          minZoom: 3,
          center: [52,7],
          basemap: 'secondary'
        }
      });

      this.children = [organizationCountry, organizationLatitude,
        organizationLongitude, organizationCity];

      this.modal = new App.View.Modal();
      this.organizationAddressForm = new App.View.OrganizationAddressForm({
        children: this.children
      });

      this.setEvents();
      this.setSubscriptions();
    },

    /**
     * Setting internal events
     */
    setEvents: function() {
      this.organizationAddressForm.on('cancel', this.closeForm, this);
      this.organizationAddressForm.on('submit', function(newState) {
        this.setState(newState);
        App.trigger('OrganizationAddressForm:submit'+this.DOMelementId, this.state.attributes);
        this.closeForm();
      }, this);

      this.mapSearch.on('center', function(center) {
        this.map.map.panTo(center);
      }.bind(this));

      this.mapSearch.on('bounds', function(bounds) {
        this.map.map.fitBounds(bounds);
      }.bind(this));

      this.map.on('pan', function(e){
        this.organizationAddressForm.setLatLngError(false);
        this.organizationAddressForm.setLocation(e.target.getCenter());
      }.bind(this));

    },

    /**
     * Subscribing to global events
     */
    setSubscriptions: function() {

    },

    /**
     * Setting form state
     * @param {Object} newState
     */
    setState: function(newState) {
      this.state.set(newState);
    },

    /**
     * Open modal and render form inside
     */
    openForm: function() {
      this.modal.open(this.organizationAddressForm);
      this.renderForm();
    },

    /**
     * Close form and modal
     */
    closeForm: function() {
      this.modal.close();
    },

    /**
     * Fetch all presenters and render all children
     */
    renderForm: function() {
      if (!this.loaded) {
        App.trigger('Modal:loading', { loading: true });

        var promises = _.compact(_.map(this.children, function(child) {
          if (child.fetchData) {
            return child.fetchData();
          }
          return null;
        }));

        $.when.apply($, promises).done(function() {
          this.loaded = true;
          this.renderFormElements();
          App.trigger('Modal:loading', { loading: false });
        }.bind(this));

      } else {
        this.renderFormElements();
        App.trigger('Modal:loading', { loading: false });
      }
    },

    renderFormElements: function() {
      this.organizationAddressForm.render();
      _.each(this.children, function(child){
        // Get && set the value from the state thanks to the name
        // I need to pass the rest of the params because there are some presenters that need other params
        // Then, inside of each presenter, they will handle its state
        var state = _.extend({}, this.state.toJSON(), {
          value: this.state.get(child.defaults.name),
        })

        child.setState(state, { silent: true });

        // Render the child
        child.render();
      }.bind(this));

      setTimeout(function() {
        this.map.setElement('#map');
        this.map.createMap();

        this.mapSearch.setElement('#map-search');
        this.mapSearch.setSearchBox();
      }.bind(this), 100)

    }

  });

})(this.App);
