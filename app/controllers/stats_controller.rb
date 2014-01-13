class StatsController < ApplicationController
  def username
    member_id = User.find_by_username(params[:username]).try(:member_id)
    if member_id
      redirect_to "/stats/member/#{member_id}"
    else
      flash[:notice] = "No users with username #{params[:username]} is registered"
      redirect_to '/register'
    end
  end

  def show
    @member = User.find_by_member_id(params[:member_id])
    if @member
      @claims = @member.claims
    else
      flash[:notice] = "No member has registered with id #{params[:member_id]}"
  	  redirect_to '/'
    end
  end
end
