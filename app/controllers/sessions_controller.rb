class SessionsController < ApplicationController
  require_relative '../services/jwt_service'
  def login
    user = User.find_by(email: params[:email])
    if user && user.valid_password?(params[:password])
      render json: { message: 'Login successful', user: user }, status: :ok
    else
      render json: { message: 'Invalid username or password' }, status: :unauthorized
    end
  end

  def authorwt
    user_id = verify_token
    user = User.find(user_id)
    if user
      render json: { message: 'Login successful', user: user }, status: :ok
    else
      render json: { message: 'Invalid username or password' }, status: :unauthorized
    end
  end

  private

  def verify_token
    token = request.headers['Authorization']&.split(' ')&.last
    decoded = Services::JwtService.decode(token)
    user_id = decoded[0]['user_id']
    return user_id
  end
end
