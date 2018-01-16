(function(App) {

  'use strict';

  App.Collection.Categories = Backbone.Collection.extend({

    url: '/api/categories',

    comparator: function(item) {
      return item.get('name');
    }

  });

})(this.App);
