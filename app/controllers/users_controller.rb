class UsersController < ApplicationController
  def create
  	user = User.create({
  	  ripple_address: params[:ripple_address],
      member_id: params[:member_id],
      username: params[:username],
      verification_code: params[:verification_code]
  	})

    render json: user
  end

  def stats
  	user = User.find(params[:id])
    claims = Claim.where(member_id: user.member_id)
    render json: {
      user: user.to_json,
      claims: claims.to_json
    }
  end
end