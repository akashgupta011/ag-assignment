class ApplicationController < ActionController::API

  def authenticate_user
    if request.headers['Authorization'].present?
      User.all.each do |user|
        if user.token
          response.headers['Authorization'] = "Bearer #{user.token}"
          return user.token
        end
      end
    else
      render json:{message: "user not authorised"}
    end
  end
#   def authenticate_user
#   authorization_header = request.headers['Authorization']

#   if authorization_header.present?
#     token = authorization_header.split(' ').last
#     user = User.find_by(token: token)

#     if user
#       response.headers['Authorization'] = "Bearer #{user.token}"
#       return user.id
#     else
#       render json: { message: "Invalid token" }, status: :unauthorized
#     end
#   else
#     render json: { message: "User not authorized" }, status: :unauthorized
#   end
# end

end
