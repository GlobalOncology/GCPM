class UsersController < ApplicationController
  before_action :set_user

  respond_to :html, :js

  def show
    # @projects = user_signed_in? && @user == current_user ? @user.projects.includes(:cancer_types).limit(params[:limit] ?
    #   params[:limit].to_i * @limit : @limit) :
    #   @user.published_projects.limit(params[:limit] ? params[:limit].to_i * @limit : @limit)
    # @isProfile = true

    @page = params.key?(:page) && params[:page] ? params[:page].to_i : 1
    @filters = %w(projects)
    @current_type = params.key?(:data) ? params[:data] : 'projects'

    gon.server_params = { 'investigators[]': @investigator.size > 0 ? @investigator.first.id : '0' }

    limit = 12 + (@page * 9)

    @projects = Project.fetch_all(user: params[:id]).uniq.order('created_at DESC')
    @people = Investigator.fetch_all(user: params[:id]).uniq.order('created_at DESC')

    if params.key?(:data) && params[:data] == 'people'
      @items = @people.limit(limit)
      @more = (@people.size > @items.size)
      @items_total = @people.size
    else
      @items = @projects.limit(limit)
      @more = (@projects.size > @items.size)
      @items_total = @projects.size
    end

    @following = 0
    @followers = 0

    respond_with(@items)
  end

  private

    def set_user
      @user = User.find(params[:id])
      @investigator = Investigator.fetch_all(user: params[:id]);
    end
end
