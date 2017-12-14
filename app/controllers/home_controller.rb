class HomeController < ApplicationController
  def index
    @featureds = Featured.home_featurables
    # @projects_total = Project.fetch_all({}).count()
    # @events_total = Event.all.distinct.count()
    # @people_total = Investigator.all.distinct.count()

    gon.isMobile = browser.device.mobile?
    gon.carto_account = ENV["CARTODB_ACCOUNT"]
    gon.carto_key = ENV["CARTODB_KEY"]

    if notice
      gon.notice = notice
    end

  end
end
