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
  
  
  has_many :favorites, dependent: :destroy
  
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy # フォロー取得
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy # フォロワー取得
  
  has_many :following_user, through: :follower, source: :followed # 自分がフォローしている人
  has_many :follower_user, through: :followed, source: :follower # 自分をフォローしている人
  
      # ユーザーをフォローする
    def follow(user_id)
      follower.create(followed_id: user_id)
    end
    
    # ユーザーのフォローを外す
    def unfollow(user_id)
      follower.find_by(followed_id: user_id).destroy
    end
    
    # フォローしていればtrueを返す
    def following?(user)
      following_user.include?(user)
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