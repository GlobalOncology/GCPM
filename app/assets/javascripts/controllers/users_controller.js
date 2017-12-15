(function(App) {

  'use strict';

  App.Controller.Users = function() {};

  _.extend(App.Controller.Users.prototype, {

    show: function(params) {
      new App.Presenter.TabNav(params);
      new App.Presenter.FollowButton(params);
      new App.Presenter.ShowMore(params);
      new App.Presenter.MessagesActions(params);
      new App.Presenter.UserMessages(params);
      new App.Presenter.UsersSearch(params);
      new App.Presenter.InvestigatorData(params);

      if (gon.isMobile) {
        new App.Presenter.UserNetworkList(params);
        new App.Presenter.UserActionsMobile(params);
      } else {
        new App.Presenter.MapVis(params);
      }
    },

    signup: function(params) {
      new App.Presenter.SignUp(params);
    }

  });

})(this.App);
