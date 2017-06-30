class Unit < ActiveRecord::Base
  has_many :positions
  belongs_to :campaign

  def self.search(search)
    self.where("name ILIKE ?", "%#{search}%")
  end
end
