class UsersController < ApplicationController
  http_basic_authenticate_with name: "ripple", password: "r!ppl3l@b5"

  def show
    if params[:ripple_address]
	    @user = User.find_by_ripple_address(params[:ripple_address])
    elsif params[:username]
	    @user = User.find_by_username(params[:username])
    end

    if @user
 			@claims = @user.claims.order(:created_at)
    else
      render status: :not_found
		end
  end
end
