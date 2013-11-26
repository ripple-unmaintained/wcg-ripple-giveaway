class Api::UsersController < ApplicationController
  def create
  	user = User.create_from_username({
  	  ripple_address: params[:ripple_address],
      username: params[:username],
      verification_code: params[:verification_code]
  	})
    if user == :service_unavailable
      render json: { error: 'service unavailable' }
    else
      if user.errors.messages.empty?
        session[:user] = { member_id: user.member_id, username: user.username }
        render json: { user: user.attributes }
      else
        render json: { error: user.errors }
      end
    end
  end
end