class Api::StatsController < ApplicationController
  def index
    if session[:user]
      wcg_team_member = Wcg.get_team_member(session[:user][:username])
      user_record = User.where(member_id: session[:user][:member_id]).first

      user_stats = WcgMemberUserStatsPresenter.new(wcg_team_member, user_record)

      render json: {
        user: user_stats,
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
