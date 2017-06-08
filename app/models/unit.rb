class Unit < ActiveRecord::Base
  has_many :positions
  belongs_to :campaign
end
