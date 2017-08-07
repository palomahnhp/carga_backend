class Position < ActiveRecord::Base
  has_one :user
  has_many :functions
  belongs_to :unit
  validates :name, :position_number, presence: true
  validates :position_number, presence: true, uniqueness: true

  def self.search(search)
    self.where("(name || position_number) ILIKE ?", "%#{search}%")
  end
end
