class Position < ActiveRecord::Base
  has_many :users
  validates :name, :position_number, presence: true, uniqueness: true
end
