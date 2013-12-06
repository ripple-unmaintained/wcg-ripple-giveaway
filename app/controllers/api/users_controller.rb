class Api::UsersController < ApplicationController
  def create
  	user = User.create_from_username({
  	  ripple_address: params.require(:ripple_address),
      username: params.require(:username),
      verification_code: params.require(:verification_code)
  	})
    if user.errors.messages.empty?
      session[:user] = { member_id: user.member_id, username: user.username }
      render json: { user: user.attributes }
    else
      render json: { error: user.errors }
    end
  end
end