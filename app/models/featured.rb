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
    unscoped.order('weight ASC').map { |f| f.featurable }
  end

  def self.home_featurables
    unscoped.order('weight ASC').where.not(featurable_type: ['Picture', 'Widget']).limit(6).map { |f| f.featurable }
  end
end
