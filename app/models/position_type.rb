class PositionType < ActiveRecord::Base
  has_many :positions
  has_many :functions
end
