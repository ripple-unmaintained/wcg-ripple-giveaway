class Api::StatsController < ApplicationController
  def index
    if session[:user]
      wcg_user_response = Wcg.get_team_member(session[:user][:username])
      user = User.where(member_id: session[:user][:member_id]).first

      total_run_time = 0
      total_points = 0

      if wcg_user_response['stats']
        total_run_time = wcg_user_response['stats'][:RunTime].to_i
        total_points = wcg_user_response['stats'][:Points].to_i
      else
        wcg_user_response['stats'] = Hash.new
      end

      wcg_user_response['stats'][:RunTime] = total_run_time - user.initial_run_time.to_i
      wcg_user_response['stats'][:Points] = total_points - user.initial_points.to_i

      render json: { user: wcg_user_response,
      	global: Stats.global
      }
    else
      render json: {}
    end
  end

  def global
    render json: Stats.global
  end
end