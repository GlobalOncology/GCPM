class OrganizationsController < ApplicationController
  before_action :set_organization, only: :show

  respond_to :html, :js

  def index
  end

  def show
    @page = params.key?(:page) && params[:page] ? params[:page].to_i : 1
    @filters = %w(projects people posts network funded_projects events)
    @current_type = params.key?(:data) ? params[:data] : 'projects'

    gon.server_params = { 'organizations[]': @organization.id }
    gon.isMobile = browser.device.mobile?

    limit = 12 + (@page * 30)

    @events = Event.fetch_all(organizations: @organization.id)
    @projects = Project.fetch_all(organizations: @organization.id).includes(:investigators).order('projects.created_at DESC')
    @people = Investigator.fetch_all(organizations: @organization.id).order('investigators.created_at DESC')
    @projects = Project.fetch_all(organizations: @organization.id).order('projects.created_at DESC')
    @people = Investigator.fetch_all(organizations: @organization.id).order('organizations.created_at DESC')
    @funded_projects = @organization.funded_projects;
    @posts = @organization.posts
    @network = []

    @projects.each do |p|
      @network.concat(p.investigators)
    end

    @network.sort_by!{|obj| obj.name}

    @network = @network.uniq()
    @events = @organization.events

    if params.key?(:data) && params[:data] == 'events'
      @items = @events.limit(limit)
      @more = (@events.size > @items.size)
      @items_total = @events.size
    elsif params.key?(:data) && params[:data] == 'people'
      @items = @people.limit(limit)
      @more = (@people.size > @items.size)
      @items_total = @people.size
    elsif params.key?(:data) && params[:data] == 'posts'
      @items = @posts.limit(limit)
      @more = (@posts.size > @items.size)
      @items_total = @posts.size
    elsif params.key?(:data) && params[:data] == 'network'
      @items = @network[0...limit];
      @more = (@network.size > @items.size);
      @items_total = @network.size
    elsif params.key?(:data) && params[:data] == 'funded_projects'
      @items = @funded_projects.limit(limit)
      @more = (@funded_projects.size > @items.size)
      @items_total = @funded_projects.size
    elsif params.key?(:data) && params[:data] == 'events'
      @items = @events.limit(limit)
      @more = (@events.size > @items.size)
      @items_total = @events.size
    else
      @items = @projects.limit(limit)
      @more = (@projects.size > @items.size)
      @items_total = @projects.size
    end

    if current_user
      @followed = current_user.following?(@organization)
      @followed_id = @organization.id
      @followed_resource = 'Organization'
    end

    respond_with(@items)
  end

  private

    def set_organization
      @organization = Organization.set_by_id_or_slug(params[:id])
    end
end
