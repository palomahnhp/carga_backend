class User < ActiveRecord::Base
  has_many :responses
  belongs_to :position

  enum user_role: { respondent: 0, admin: 1, superadmin: 2 }

  def self.search(search)
    self.where("(name || last_name || last_name_alt) ILIKE ?", "%#{search}%")
  end
end
