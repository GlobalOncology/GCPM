(function(App) {

  'use strict';

  App.Controller = App.Controller || {};

  App.Controller.User = App.Controller.Page.extend({

    index: function(params) {
      this.params = params;
      // Id 6 is the custom basemap rendered as a carto layer
      var layersActived = [2, 6];

      var layersSpec = this.layersSpec = new App.Collection.LayersSpec();
      var options = {
        basemap: null
      };
      var map = this.map = new App.View.Map({
        el: '#map',
        collection: this.layersSpec,
        params: this.params,
        options: options
      });

      layersSpec.on('change, reset', function() {
        map.renderLayers();
      });

      layersSpec.fetch().done(function() {
        // This method triggers an event called 'reset'
        layersSpec.filterByIds(layersActived);
      });

      this._initMapComponents();
    },

    _initMapComponents: function() {
      new App.View.MapMenu({
        params: this.params
      });

      new App.View.MapTypes({
        params: this.params
      });
    }

  });


})(this.App);
