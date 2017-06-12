class User < ActiveRecord::Base
  has_and_belongs_to_many :campaigns
  has_many :responses
  belongs_to :position
end
