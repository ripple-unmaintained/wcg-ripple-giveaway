class Api::StatsController < ApplicationController
  def index
    if session[:user]
      render json: { user: Wcg.get_team_member(session[:user][:username]),
      	claims: Claim.where(member_id: session[:user][:member_id])
      }
    else
      render json: {}
    end
  end
end