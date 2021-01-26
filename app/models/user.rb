class User < ApplicationRecord
  has_many :tasks,dependent: :destroy
  validates :name,  presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: true
  before_validation { email.downcase! }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
  before_update :last_admin_update
  before_destroy :last_one_admin_destory
    private
    def last_admin_update
      if User.all.where(admin:[true]).count == 1 &&self.admin == false
        throw(:abort)
      end
    end
    def last_one_admin_destory
      if User.all.where(admin:[true]).count == 1 &&self.admin == true
        throw(:abort)
      end
    end

end
