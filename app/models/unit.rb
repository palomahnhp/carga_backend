class Unit < ActiveRecord::Base
  has_many :users
  has_many :positions
end
