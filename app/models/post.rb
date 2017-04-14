class Post < ApplicationRecord
  validates :content, presence: true
  belongs_to :user

  has_many :likes, :dependent => :destroy
  has_many :liked_users, :through => :likes, :source => :user

  has_many :collections, :dependent => :destroy
  has_many :collected_users, :through => :collections, :source => :user
  
  def find_like(user)
    self.likes.where(:user_id => user.id).first
  end
end
