class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def create_token
    payload = { user_id: self.id, exp: 8.hours.from_now.to_i }
    token = JwtService.encode(payload)
    return token.to_s
  end
end
