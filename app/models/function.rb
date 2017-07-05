class Function < ActiveRecord::Base
  has_many :responses
  belongs_to :position

  def self.search(search)
    self.where("name ILIKE ?", "%#{search}%")
  end
end
