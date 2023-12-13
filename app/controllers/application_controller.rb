class ApplicationController < ActionController::API

  def authenticate_user
    if request.headers['Authorization'].present?
      User.all.each do |user|
        if user.token == request.headers['Authorization']
          response.headers['Authorization'] = "Bearer #{@token}"
          return user.id
        end
        return if user.blank?
      end
    else
      render json:{message: "user not authorised"}
    end
  end

end
