class Position < ActiveRecord::Base
  has_many :users
  has_many :functions
  belongs_to :unit
  validates :name, :position_number, presence: true, uniqueness: true
end
