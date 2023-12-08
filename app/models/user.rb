class User < ApplicationRecord
 # Here if one user is destroyed then his post will also deleted in remove account 
  has_many :posts, dependent: :destroy

  # Basical associations for user
  validates :name, presence: true
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }

  # this method is for checking password true or not
  def authenticate(password)
    self.password == password
  end

end