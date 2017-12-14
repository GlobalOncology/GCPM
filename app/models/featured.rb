# == Schema Information
#
# Table name: featureds
#
#  id              :integer          not null, primary key
#  featurable_id   :integer
#  featurable_type :string
#  weight          :integer          default(0)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Featured < ApplicationRecord
  belongs_to :featurable, polymorphic: true
  def self.featurables
    unscoped.order('weight DESC').map { |f| f.featurable }
  end

  def self.home_featurables
    allFeatured = unscoped.order('weight DESC')
    homeFeatured = []
    featuredTypes = ['Picture'] #include Picture so it won't be pulled into the list

    allFeatured.each do |f|
      if featuredTypes.index(f.featurable_type).nil? && homeFeatured.size < 6
        featuredTypes.push(f.featurable_type)
        homeFeatured.push(f.featurable)
      end
    end

    homeFeatured
  end
end
