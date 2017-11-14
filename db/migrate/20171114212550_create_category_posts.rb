class CreateCategoryPosts < ActiveRecord::Migration[5.0]
  def change
    create_table :category_posts do |t|
      t.references :post, index: true, foreign_key: true
      t.references :category, index: true, foreign_key: true

      t.timestamps
    end
  end
end
