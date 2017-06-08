class User < ActiveRecord::Base
  has_many :responses
  belongs_to :position
end
