class User < ActiveRecord::Base
  has_many :responses
  has_and_belongs_to_many :positions

  def self.search(search)
    self.where("(name || last_name || last_name_alt) ILIKE ?", "%#{search}%")
  end
end
