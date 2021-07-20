class Api::V1::UserSessionsController < ApplicationController
    def create
      @user = User.find_by(email: params[:email])
      if @user&.authenticate(params[:password])
        render json: @user, only: %i[username authentication_token], status: :ok
      else
        render json: { failure: 'There is no such user.' }, status: :unauthorized
      end
    end
end