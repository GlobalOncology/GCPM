# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string
#  body       :text
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ApplicationRecord
  include ActAsFeatured
  include PgSearch

  belongs_to :user

  after_create :notify_users_for_update

  has_many :pins
  has_many :countries,     through: :pins, source: :pinable, source_type: 'Country'
  has_many :projects,      through: :pins, source: :pinable, source_type: 'Project'
  has_many :organizations, through: :pins, source: :pinable, source_type: 'Organization'
  has_many :cancer_types,  through: :pins, source: :pinable, source_type: 'CancerType'
  has_many :specialities,  through: :pins, source: :pinable, source_type: 'Speciality'
  has_many :category_posts
  has_many :categories,    through: :category_posts

  validates_presence_of :title, :body

  pg_search_scope :search_by_content,
    :against => {
      :title => 'A',
      :body => 'B'
    },
    :using => {
      :tsearch => {:prefix => true}
    }

  pg_search_scope :search_by_organization, :associated_against => {
    :organizations => [:name]
  }

  pg_search_scope :search_by_project, :associated_against => {
    :projects => [:title]
  }

  pg_search_scope :search_by_cancer_type, :associated_against => {
    :cancer_types => [:name]
  }

  pg_search_scope :search_by_speciality, :associated_against => {
    :specialities => [:name]
  }

  pg_search_scope :search_by_author, :associated_against => {
    :user => [:name]
  }

  pg_search_scope :search_by_category, :associated_against => {
    :categories => [:name]
  }

  pg_search_scope :search_by_country, :associated_against => {
    :countries => [:country_name]
  }

  default_scope { order('created_at DESC') }

  def build_pins(options)
    options.each do |pinable_type, pinable_ids|
      pinable_ids.each do |pinable_id|
        Pin.where(pinable_type: pinable_type.classify, pinable_id: pinable_id, post_id: self.id).first_or_create
      end
    end
  end

  def all_categories=(categories)
    self.categories = categories.map do |name|
      Category.where(name: name.strip).first_or_create!
    end
  end

  def all_categories
    self.categories.map(&:name).join(', ')
  end

  private

    def notify_users_for_update
      users = ActivityFeed.where(actionable_type: 'User', actionable_id: user_id, action: 'following').pluck(:user_id)
      if users.any?
        creator = User.find(user_id).try(:name)
        Notification.build(users, self, "was created by #{creator}")
      end
    end
end
