class Diary < ApplicationRecord
  belongs_to :user
  validates :title, presence: true, length: { maximum: 255 }
  validates :body, presence: true, length: { maximum: 10_000 }
  validate :proper_title_and_body
  validates :user_id, {presence: true}
  
  def user
    return User.find_by(id: self.user_id)
  end
  
  
  
  private
  
  def proper_title_and_body
    unless title.starts_with?('最高の')
      errors.add(:title, 'は「最高の」から始めてください。')
    end
    unless body.ends_with?('ありがとう。')
      errors.add(:body, 'は「ありがとう。」で終了してください')
    end
  end
end
