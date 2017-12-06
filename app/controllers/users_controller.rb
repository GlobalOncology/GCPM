class UsersController < ApplicationController
  before_action :set_user
  before_action :check_user, only: [:show, :edit, :update]

  respond_to :html, :js

  def show
    @page = params.key?(:page) && params[:page] ? params[:page].to_i : 1
    @filters = %w(network projects posts events)

    if current_user == @user
      @filters.push('messages')
    end

    @current_type = params.key?(:data) ? params[:data] : 'projects'

    gon.server_params = { 'user': @investigator.present? ? @investigator.id : '0' }
    gon.userId = current_user.id
    gon.unreadCount = current_user.unread_inbox_count
    gon.isMobile = browser.device.mobile?

    limit = 12 + (@page * 9)

    @projects = @user.projects.to_a

    if @user.investigator.present?
      @investigatorProjects = @user.investigator.projects
      if @investigatorProjects.size > 0
        @projects.concat(@investigatorProjects.to_a)
      end
    end

    @projects = @projects.sort{ |a, b| b.created_at <=> a.created_at }

    @people = @user.investigator
    @posts = @user.posts
    @events = @user.events.order_by_upcoming
    @conversations = Mailboxer::Conversation.joins(:receipts).where(mailboxer_receipts: { receiver_id: current_user.id, deleted: false }).uniq.page(params[:page]).order('created_at DESC')
    @followingCount = @user.following_users_count || 0
    @followersCount = @user.followers_by_type_count('User') || 0

    if params.key?(:data) && params[:data] == 'network'
      @followProjects = @user.following_by_type('Project')
      @followEvents = @user.following_by_type('Event')
      @followPeople = @user.following_by_type('Investigator')
      @followUser = @user.following_by_type('User')
      @followCancerTypes = @user.following_by_type('CancerType')
      @followCountries = @user.following_by_type('Country')
      @followOrganizations = @user.following_by_type('Organization')
      @followers = @user.followers_by_type('User')
    elsif params.key?(:data) && params[:data] == 'posts'
      @items = @posts.first(limit)
      @more = (@posts.size > @items.size)
      @items_total = @posts.size
    elsif params.key?(:data) && params[:data] == 'events'
      @items = @events.limit(limit)
      @more = (@events.size > @items.size)
      @items_total = @events.size
    elsif params.key?(:data) && params[:data] == 'messages'
      @items = @conversations.limit(limit)
      @more = (@conversations.size > @items.size)
      @items_total = @conversations.size
    else
      @items = @projects.slice(0, limit)
      @more = (@projects.size > @items.size)
      @items_total = @projects.size
    end

    if current_user
      @followed = current_user.following?(@user)
      @followed_id = @user.id
      @followed_resource = 'User'
    end

    respond_with(@items)
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(current_user.id)
    else
      redirect_to edit_user_path(current_user.id)
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
    @investigator = Investigator.find_by(user_id: params[:id]);
  end

  def user_params
    params.require(:user).permit(:name, :email, :position, :twitter_account, :linkedin_account, :pubmed, :avatar)
  end

  def check_user
    if !current_user
      redirect_to new_user_session_path and return
    elsif action_name != 'show' && current_user != @user
      redirect_to map_path and return
    end
  end
end
