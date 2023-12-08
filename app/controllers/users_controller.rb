class UsersController < ApplicationController

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
    if $user.present?
      render json: {message: "first do logout"}
    else
      @user = User.find_by(email: params[:email]) || User.find_by(username: params[:username])
      if @user && @user.authenticate(params[:password])
        $user = @user
        render json: {message: "user logged in successfully"}
      else
        render json: { error: 'Invalid email or password' }, status: :unauthorized
      end
    end
  end

  # current user will be shown
  def show 
    if $user
      render json: { name: $user.name, user_name: $user.username, email: $user.email}
    else
      render json: { error: 'User not found' }, status: :not_found
    end
  end

  # current user can update itself
  def update
    return render json:{message: "user not logged in"} if $user == nil
    if $user.update(user_params)
      render json: { message: 'User details updated successfully' }
    else
      render json: { error: $user.errors.full_messages.join(', ') }, status: :unprocessable_entity
    end
  end

  # Current user can end session of itself
  def logout
    if $user
      $user = nil
      render json: { message: 'User logged out' }
    else
      render json: {message: "something went wrong no user found"}
    end
  end

  #current user can remove their account
  def remove_account
    if $user
      $user.destroy
      $user = nil
      render json: {message: "user account has been removed"}
    else
      render json: {message: "It seems there is no user logged in"}
    end
  end
    
  private

  def user_params
    params.require(:user).permit(:name, :username, :email, :password)
  end

end
