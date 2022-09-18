class User < ApplicationRecord
  validates :uid, uniqueness: true

  def self.find_by_uid(uid)
    self.find_by(uid:)
  end
end
