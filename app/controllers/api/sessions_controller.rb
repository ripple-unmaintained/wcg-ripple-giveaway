class Api::SessionsController < ApplicationController
  def create
    if (wcg_user_response = Wcg.verify_user(params[:username], params[:verification_code]))
      if wcg_user_response != :service_unavailable
        session[:user] = wcg_user_response
        render json: wcg_user_response
      else
        render json: { error: 'service unavailable' }
      end
    else
      render json: { error: 'invalid username or verification code' }
    end
  end

  def show
    render json: session[:user]
  end
end