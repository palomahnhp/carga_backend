class Position < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :functions
  belongs_to :position_type
  belongs_to :unit
  validates :name, :position_number, presence: true
  validates :position_number, presence: true, uniqueness: true

  def self.search(search)
    self.where("name ILIKE ?", "%#{search}%")
  end
end
