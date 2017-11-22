(function(App) {

  'use strict';

  var StateModel = Backbone.Model.extend();

  App.Presenter.OrganizationAddress = function() {
    this.initialize.apply(this, arguments);
  };

  _.extend(App.Presenter.OrganizationAddress.prototype, {

    defaults: {
      multiple: false,
      name: 'address',
      label: 'Address',
      placeholder: 'Select location',
      blank: null,
      addNew: true,
      select2Options: {
        minimumResultsForSearch: -1
        // closeOnSelect: false
        // It solves the closing of the dropdown menu
        // It adds a lot of UX issues
        // - Scroll: On select, scroll will go to first highlighted choice => How to resolve the scroll issue https://github.com/select2/select2/issues/1672#issuecomment-240411031
        // - Click: On each click dropdown will appear and dissapear
      }
    },

    initialize: function(viewSettings) {
      this.state = new StateModel();
      this.selector = viewSettings.DOMelement;
      this.selectedOrg = null;

      this.addressForm = new App.Presenter.OrganizationAddressForm({
        DOMelementId: this.selector
      });

      // Creating view
      this.select = new App.View.Select({
        el: viewSettings.DOMelement,
        options: _.extend({}, this.defaults, viewSettings || {}),
        state: this.state
      });

      this.setEvents();
      this.setSubscriptions();
    },

    /**
     * Setting internal events
     */
    setEvents: function() {
      this.select.on('change', function(newState){
        this.setState(newState);
        App.trigger('OrganizationAddress:change', this.state.attributes);
      }, this);

      this.select.on('new', function(){
        if (!this.state.attributes.value) {
          alert('You must select an organization first.');
          return;
        }

        this.addressForm.openForm();
      }, this);
    },

    setValue: function(value){
      this.select.$el.find("select").val(value).trigger("change");
    },

    setFetchedValues: function(value){
      var vals = [{
        name: value.line_1,
        value: value.id
      }];
      this.select.setOptions(vals);
      this.select.render();
      this.select.$el.find("select").val(value.id).trigger("change");
    },

    setAddressFromData: function(data, addNew){
      var countryId = data.value.organizationCountry;
      var countries = new App.Collection.Countries();
      countries.fetch().done(function(){
        var countryData = countries.map(function(type) {
          return {
            name: type.attributes.name,
            id: type.attributes.id
          };
        });

        var selected = {};
        _.each(countryData, function(country){
          if(parseInt(countryId) == country.id){
            selected = country;
            return true;
          }
        });

        var name = selected.name;

        if (data.value.organizationCity) {
          name = data.value.organizationCity + ', ' + name;
        }

        if (addNew === true) {
          var value = JSON.stringify(data.value);
          this.select.addNew({
            name: name,
            value: value
          });
          this.select.setValue(value);
        } else {
          this.select.setOptions([{
            name: name,
            value: selected.id
          }]);
        }

        this.select.render();

      }.bind(this));
    },

    setSubscriptions: function(){
      App.on('Organization:#organization-'+this.selector.split("-")[1], function(data){
        if(data.value.length > 0) {
          if (!isNaN(parseInt(data.value[0]))){
            var organizationId = data.value[0];
            if (this.selectedOrg == organizationId) {
              return;
            }

            this.selectedOrg = organizationId;
            new Promise(function(resolve){
              var url = "/api/organizations/"+organizationId;
              var q = new XMLHttpRequest();
              q.open('GET', url, true);
              q.onreadystatechange = function(){
                if(this.readyState == 4 && this.status == 200){
                  if(this.response !== undefined && this.response !== ""){
                    resolve(this.response);
                  }
                }
                // else if(ERROR){
                //   reject(q.response);
                // }
              }
              q.send();
            }).then(function(data){
              var response = JSON.parse(data);
              var addresses = response.addresses;
              var options = addresses.map(function(address) {
                return {
                  name: address.line_1+" "+address.city+", "+address.country_name,
                  value: address.id
                };
              });
              if(options.length > 0){
                this.select.setOptions(options);
                this.select.render();
                if (options[0]) {
                  this.select.setValue(options[0].value);
                }
              }
            }.bind(this)).catch(function(response){
              throw Error(response);
            });
          } else {
            this.setAddressFromData({value: JSON.parse(data.value[0])});
          }
        }
      }, this);

      App.on('OrganizationAddressForm:submit' + this.selector, function(data){
        this.setAddressFromData({value: data}, true);
        App.trigger('NewOrganizationAddress', {
          selector: this.selector,
          data: data
        });
      }, this);
    },


    render: function() {
      this.select.render();
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
