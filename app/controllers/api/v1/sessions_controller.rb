class Api::V1::SessionsController < ApplicationController
    def create
      @trader = Trader.find_by(email: params[:email])
      if @trader&.authenticate(params[:password])
        render json: @trader, only: %i[name authentication_token], status: :ok
      else
        render json: { failure: 'There is no such user.' }, status: :unauthorized
      end
    end
  end