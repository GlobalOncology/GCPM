class PostsController < InheritedResources::Base
  load_and_authorize_resource

  before_action :set_user,    only: [:new, :create, :edit, :update]
  before_action :check_user, only: [:new, :create]

  def index
    # which page are we on
    @page = params.key?(:page) && params[:page] ? params[:page].to_i : 1

    # how many posts should we show
    limit = 10 * @page

    # get all the posts
    @posts = Post.all.order(updated_at: :desc)

    # are we searching
    if params[:q].present?
      @posts = @posts.search_by_content(params[:q].strip);
    end

    # figure out which posts to display, if there's more to display, and how many posts exist
    @items = @posts.first(limit)
    @more = (@posts.size > @items.size)
    @items_total = @posts.size
  end

  def new
    @post = Post.new
  end

  def edit
    gon.server_params = {
      'post[countries][]': @post.countries.pluck(:id),
      'post[organizations][]': @post.organizations.pluck(:id),
      'post[projects][]': @post.projects.pluck(:id),
      'post[cancer_types][]': @post.cancer_types.pluck(:id),
      'post[specialities][]': @post.specialities.pluck(:id),
      'post[all_categories][]': @post.categories.pluck(:name)
    }
  end

  def update
    if @post.update(post_params)
      @post.build_pins(pins_params) if pins_params.present?
      redirect_to posts_url, notice: 'Post updated'
    else
      render :edit
    end
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user

    if @post.save
      @post.build_pins(pins_params) if pins_params.present?
      redirect_to post_path(@post.id)
    else
      redirect_to new_post_path(error: true)
    end
  end

  private
    def set_user
      @user = current_user
    end

    def post_params
      params.require(:post).permit(:title, :body, :user_id, { organizations: [] }, { cancer_types: [] }, { projects: [] }, { countries: [] }, { specialities: [] }, { all_categories: [] })
                           .except(:organizations, :cancer_types, :projects, :countries, :specialities)
    end


    def pins_params
      params.require(:post).permit(:title, :body, :user_id, { organizations: [] }, { cancer_types: [] }, { projects: [] }, { countries: [] }, { specialities: [] }, { all_categories: [] })
                           .except(:title, :body, :user_id)
    end

    def check_user
      if !current_user
        redirect_to new_user_session_path and return
      end
    end
end
