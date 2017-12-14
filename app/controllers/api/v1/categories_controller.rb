module Api::V1
  class CategoriesController < ApiController
    def index
      categories = Category.all
      render json: categories, each_serializer: CategoryArraySerializer
    end
  end
end
