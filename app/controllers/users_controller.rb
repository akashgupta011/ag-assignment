class UsersController < ApplicationController
  # before_save :hash_email
  before_action :set_user, only: [:show, :update, :logout, :remove_account]

  #here we are creating user or we can say that, "here we are doing signup"
  def create
    @user = User.new(user_params)
    if @user.save
      render json: { message: 'User successfully created' }, status: :created
    else
      render json: { error: @user.errors.full_messages.join(', ') }, status: :unprocessable_entity
    end
  end

  # By this method user can login by email or username with containing password
  def login
    if @user.present?
      render json: {message: "first do logout"}
    else
      @user = User.find_by(email: params[:email]) || User.find_by(username: params[:username])
      if @user && @user.authenticate(params[:password])
        @token = User.generate_token
        @user.update(token:@token)
        render json: {message: "user logged in successfully"}
      else
        render json: { error: 'Invalid email or password' }, status: :unauthorized
      end
    end
  end

  # current user will be shown
  def show 
    return render json:{message: "user not logged in"} if @user.token == nil
    authenticate_user(@user.token)
    if @user
      render json: { name: @user.name, username: @user.username, email: @user.email}
    else
      render json: { error: 'User not found' }, status: :not_found
    end
  end

  # current user can update itself
  def update
    return render json:{message: "user not logged in"} if @user.token == nil
    if @user.update(user_params)
      render json: { message: 'User details updated successfully' }
    else
      render json: { error: @user.errors.full_messages.join(', ') }, status: :unprocessable_entity
    end
  end

  # Current user can end session of itself
  def logout
    if @user
      @user.update(token: nil)
      render json: { message: 'User logged out' }
    else
      render json: {message: "something went wrong no user found"}
    end
  end

  #current user can remove their account
  def remove_account
    if @user
      @user.destroy
      render json: {message: "user account has been removed"}
    else
      render json: {message: "It seems there is no user logged in"}
    end
  end
    
  private

  def set_user
    begin
      @user  =  User.find(params[:id])
    rescue
      render json: {message: "user not found"}
    end    
  end

  def user_params
    params.require(:user).permit(:name, :username, :email, :password, :token)
  end

  def authenticate_user(token)
    response.headers['token'] = 'true'
    # token = request.headers['Authorization']&.split&.last
    
    unless valid_token?.present?
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end

  def valid_token?
    @current_user = User.find_by(token: @user.token)
    @current_user.present?
  end

end
