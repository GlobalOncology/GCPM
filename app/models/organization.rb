# == Schema Information
#
# Table name: organizations
#
#  id                   :integer          not null, primary key
#  name                 :string
#  acronym              :string
#  grid_id              :string
#  email_address        :string
#  established          :integer
#  organization_type_id :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

class Organization < ApplicationRecord
  has_many :addresses
  belongs_to :organization_type
  has_many :memberships
  has_many :investigators, through: :memberships
  accepts_nested_attributes_for :addresses, allow_destroy: true
  has_many :projects, through: :memberships
end
