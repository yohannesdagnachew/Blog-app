class Api::AuthenticationController < ApplicationController
    before_action :authorize_request, except: :login
    protect_from_forgery with: :null_session
    # POST /auth/login
  
    def login
      @user = User.find_by_email(params[:email])
  
      if @user&.valid_password?(params[:password])
        token = ApiHelper::JsonWebToken.encode(user_email: @user.email)
        time = Time.now + 2.hours.to_i
        render json: { token: token, exp: time.strftime('%m-%d-%Y %H:%M'),
                       name: @user.name }, status: :ok
      else
        render json: { error: 'unauthorized' }, status: :unauthorized
      end
    end
  
    private
  
    def login_params
      params.permit(:email, :password)
    end
end