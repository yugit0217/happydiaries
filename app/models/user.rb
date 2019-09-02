class User < ApplicationRecord
  has_many :diaries
  validates :name, {presence: true}
  validates :email, {presence: true, uniqueness: true}
  validates :password, {presence: true}
  
  
  def diaries
    return Diary.where(user_id: self.id)
  end
  
end
