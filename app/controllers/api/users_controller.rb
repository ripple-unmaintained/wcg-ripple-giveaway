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

  def stats
  	user = User.find(params[:id])
    claims = Claim.where(member_id: user.member_id)
    render json: {
      user: user.to_json,
      claims: claims.to_json,
      stats: Wcg.get_team_member(user.member_id)
    }
  end
end