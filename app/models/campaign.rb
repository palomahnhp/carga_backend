class Campaign < ActiveRecord::Base
  has_many :units
  enum status: { pending: 0, active: 1, completed: 2 }
end
