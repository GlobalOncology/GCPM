#  id         :integer          not null, primary key
#  title      :string
#  body       :text
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null

ActiveAdmin.register Category do
  menu parent: "Entities"
  permit_params :name

  form do |f|
    f.semantic_errors
    f.inputs 'Category Details' do
      f.input :name
    end
    actions
  end

  index do
    selectable_column
    column :id
    column :name
    actions
  end

  csv do
    column(:id)
    column(:name)
    column(:created_at)
    column(:updated_at)
  end
end
