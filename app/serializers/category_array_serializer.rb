class CategoryArraySerializer < ActiveModel::Serializer
  attributes :id, :name

  def name
    object.try(:name)
  end

end
