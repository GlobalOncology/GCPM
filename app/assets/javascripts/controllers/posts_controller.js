(function(App) {

  'use strict';

  App.Controller.Posts = function() {};

  _.extend(App.Controller.Posts.prototype, {

    index: function(params) {
      new App.Presenter.ShowMore(params);
      var spinner = '<div class="c-spinner -start"><div class="spinner-box"><div class="icon"></div></div></div>';
      var bindShowMoreClick =  function(){
        $('#showMoreButton').on('click', function(){
          $(this).html(spinner);
        });
      };

      App.on('Blog:paginate', function(data){
        Backbone.history.navigate(data.url);
      });

      App.on('Remote:load', bindShowMoreClick);
      bindShowMoreClick();
    },

    show: function(params) {
      new App.View.ShareButton({ el: '.js-share-button' });
      new App.Presenter.Share(params);
    },

    new: function(params) {
      new App.Presenter.PostFormPresenter(params);
    },

    edit: function(params) {
      var newParams = _.extend({}, params, gon.server_params);
      new App.Presenter.PostFormPresenter(newParams);
    }

  });

})(this.App);
