class User < ApplicationRecord
  require 'securerandom'
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

  # def self.generate_token(user)
  #   # Customizing the payload
  #   payload = { user_id: user.id }
    
  #   # Use a strong secret key for encryption
  #   secret_key = 'c8fa3cc38ed50b339ed516e5210dbff4dd486cce39467df8b345c278ca12013fb96382ce6ed5deb0bbfce746efe9e625cb86e5016e69e458e702b2202ee8b8ce'
    
  #   # Encrypt the token
  #   token = JWT.encode(payload, secret_key, 'HS256')
    
  #   # Return the encrypted token
  #   token
  # end

  # def self.encode_token
  #   user = User.find_by(params[:user_id])
  #   # jwt = user.token
  #   # header, payload, signature = jwt.split('.')
  #   # decoded_payload = Base64.decode64(payload)
  # end
  
  def self.generate_token
      token = SecureRandom.hex(6)
      token.gsub!(/\W/, '')
      token = token[0, 12]

    return token
  end

end