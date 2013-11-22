class Api::StatsController < ApplicationController
  def index
    if session[:user]
      wcg_user_response = Wcg.get_team_member(session[:user][:username])
      if wcg_user_response != :service_unavailable
        render json: { user: wcg_user_response,
        	claims: Claim.where(member_id: session[:user][:member_id]),
        	global: Stats.global
        }
      else
        render json: { error: 'service unavailable' }
      end
    else
      render json: {}
    end
  end
end