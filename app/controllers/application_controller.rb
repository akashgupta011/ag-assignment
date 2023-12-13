class ApplicationController < ActionController::API

  def authenticate_user
    if request.headers['Authorization'].present?
      User.all.each do |user|
        if user.token
          response.headers['Authorization'] = "Bearer #{user.token}"
          return user.id
        end
        return if user.blank?
      end
    else
      render json:{message: "user not authorised"}
    end
  end

end
