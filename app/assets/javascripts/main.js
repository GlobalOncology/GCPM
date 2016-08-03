(function(App) {

  'use strict';
  /**
   * Main Application View
   */
  App.MainView = Backbone.View.extend({

    /**
     * Main DOM element
     * @type {Object}
     */
    el: 'body',

    events: {
      'click a[data-magic]': 'isMagicLink'
    },

    initialize: function() {
      this.$content = $('#content');
      this.router = new App.Router();
      this.listeners();
    },

    listeners: function() {
      this.listenTo(this.router, 'route', this.initCommonViews);
      this.listenTo(this.router, 'route:map', this.mapPage);
      this.listenTo(this.router, 'route:countries', this.countriesPage);
      this.listenTo(this.router, 'route:country', this.countryPage);
      this.listenTo(this.router, 'route:network', this.userPage);

      // Listening magic links
      App.Events.on('remote:load', this.replaceContent);
      
      // Update params
      App.Events.on('params:update', this.publishParams.bind(this));

    },

    start: function() {
      Backbone.history.start({ pushState: true });
    },

    stop: function() {
      Backbone.history.stop();
    },

    update: function() {
      console.log('update please');
    },

    /**
     * Use data-magic attribute with remote: true
     * @param  {Event}  e
     */
    isMagicLink: function(e) {
      var href = e.currentTarget.getAttribute('href');
      this.router.navigate(href);
    },

    initCommonViews: function() {
      new App.View.MobileHeader();
      new App.View.UserDropdownMenu();
    },

    replaceContent: function(data) {
      console.log('replace content');
      console.log(data);
      var contentElement = document.getElementById('content');
      if (contentElement) {
        contentElement.innerHTML = data.content;
      }
    },

    mapPage: function() {
      this.params = this.setParams(this.router.getParams());
      var layersCollection = new App.Collection.Layers();

      // Views
      new App.View.Map({
        layers: layersCollection,
        params: this.params
      });

      new App.View.MapMenu();
      new App.View.MapFilters({
        params: this.params
      });
      new App.View.MapLayers();
    },

    countriesPage: function() {
      this.params = this.setParams(this.router.getParams());
      /* Countries index search view */
      var regionsCollection = new App.Collection.Regions();
      var regionsView = new App.View.SearchList({
        searchList: regionsCollection,
        options: {
          isTwoLevels: true,
          template: HandlebarsTemplates['countries-list'],
          innerSearchListName: 'countries',
          itemSearchedCategory: 'country_name'
        }
      });

      regionsCollection.fetch();
    },

    countryPage: function() {
      this.params = this.setParams(this.router.getParams());
      // Map view
      var layersCollection = new App.Collection.Layers();
      var mapView = new App.View.Map({
        layers: layersCollection,
      });
    },

    userPage: function() {
      this.params = this.setParams(this.router.getParams());
      // Map view
      var layersCollection = new App.Collection.Layers();
      var mapView = new App.View.Map({
        layers: layersCollection,
      });
    },

    /**
     * - setParams
     * - publishParams
     * This function will parse the params of the url
     */
    setParams: function(params) {
      if (params['regions[]']) {
        params.group = 'countries';
      }

      if (params['countries[]']) {
        params.group = 'projects';
      }

      return params;
    },

    publishParams: function(newParams) {
      this.params = _.extend({}, this.params, newParams);
      this.params = this.stripNull(this.params);
      this.router.navigate('/map?' + $.param(this.params));
      Turbolinks.visit('/map?' + $.param(this.params));
    },

    stripNull: function(obj) {
      for (var i in obj) {
        if (! !!obj[i]) delete obj[i];
        if (_.isArray(obj[i]) && ! !!obj[i].length) delete obj[i];
      }
      return obj;
    }    

  });

})(this.App);
