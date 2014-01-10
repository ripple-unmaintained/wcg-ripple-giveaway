class StatsController < ApplicationController
  def username
    member_id = User.find_by_username(params[:username]).try(:member_id)
    if member_id
      flash[:notice] = "No users with username #{params[:username]} is registered"
      redirect_to '/'
    else
      redirect_to "/stats/member/#{member_id}"
    end
  end

  def show
    @member = User.find_by_member_id(params.require[:member_id])
    unless !@member
      flash[:notice] = "No member has registered with id #{params[:member_id]}"
  	  redirect_to '/'
    end
  end
end
