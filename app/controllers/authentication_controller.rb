class AuthenticationController < ApplicationController
 skip_before_action :authenticate_request

  def authenticate
    email, password = auth_params.values_at(:email, :password)

    get_token(email, password);
  end

  def sign_up
    @user = User.new(auth_params)

    if @user.save
      get_token(@user.email, @user.password)
    else
      render json: { error: @user.errors }, status: :unauthorized
    end
  end

  private

    def auth_params
      params.permit(:email, :password)
    end

    def get_token(email, password)
      command = AuthenticateUser.call(email,password)

      if command.success?
        render json: { token: command.result }
      else
        render json: { error: "credenciais inválidas" }, status: :unauthorized
      end

    end
 
end