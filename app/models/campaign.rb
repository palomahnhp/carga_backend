class Campaign < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :units
  enum status: { pending: 0, active: 1, completed: 2 }
end
