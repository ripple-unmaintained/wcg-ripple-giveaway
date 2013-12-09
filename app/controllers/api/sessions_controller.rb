class Api::SessionsController < ApplicationController
  def create
    if (wcg_user = Wcg.verify_user(params.require(:username), params.require(:verification_code)))
      if User.where(member_id: wcg_user.id).present?
        session[:user] = {
          member_id: wcg_user.id,
          username: wcg_user.name
        }
        render json: wcg_user
      else
        render json: { error: 'no registration' }
      end
    else
      render json: { error: 'invalid username or verification code' }
    end
  end

  def show
    render json: session[:user]
  end

  def language
    session[:language] = params[:language]
    render json: { language: params[:language] }
  end
end