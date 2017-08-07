class Unit < ActiveRecord::Base
  has_many :positions
  belongs_to :campaign

  def self.search(search)
    self.where("(name || dir_name || subdir_name || unit_number) ILIKE ?", "%#{search}%")
  end
end
