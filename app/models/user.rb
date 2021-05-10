class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books
  attachment :profile_image, destroy: false

  validates :name, length: {maximum: 20, minimum: 2}, uniqueness: true
  validates :introduction, length: { maximum: 50 }
  
  has_many :book_comments, dependent: :destroy
  
  has_many :user_rooms
  has_many :chats
  has_many :rooms, through: :user_rooms
  
  has_many :favorites, dependent: :destroy
  
  # 自分がフォローされる（被フォロー）側の関係性
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # 自分がフォローする（与フォロー）側の関係性
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  # 被フォロー関係を通じて参照→自分をフォローしている人
  has_many :followers, through: :reverse_of_relationships, source: :follower
  # 与フォロー関係を通じて参照→自分がフォローしている人
  has_many :followings, through: :relationships, source: :followed
      # ユーザーをフォローする
    def follow(user_id)
      relationships.create(followed_id: user_id)
    end    
    
    
    def unfollow(user_id)
      relationships.find_by(followed_id: user_id).destroy
    end
    
    # フォローしていればtrueを返す
    def following?(user)
      followings.include?(user)
    end
    
    #都道府県
    include JpPrefecture
    jp_prefecture :prefecture_code

    def prefecture_name
    JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
    end

    def prefecture_name=(prefecture_name)
    self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code
    end

end