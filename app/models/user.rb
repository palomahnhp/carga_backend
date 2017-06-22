class User < ActiveRecord::Base
  has_many :responses
  has_and_belongs_to_many :positions
end
