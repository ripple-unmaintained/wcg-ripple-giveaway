class Api::SessionsController < ApplicationController
  def create
    if (user = Wcg.verify_user(params[:username], params[:verification_code]))
      session[:user] = user
      render json: user
    else
      render json: { error: 'invalid username or verification code' }
    end
  end

  def show
    render json: session[:user]
  end
end