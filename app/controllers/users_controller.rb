class UsersController < ApplicationController
  before_filter :registration, only: :create

  def new
  end

  def create
    if verify_user
      @user = User.find_or_create({
        ripple_address: @ripple_address,
        username: @username,
        member_id: @member.id
      }) 
      redirect_to "/stats/member/#{@user.member_id}"
    else
      flash[:notice] = { username: "The credentials provided do not belong to a Ripple Labs WCG team member"}
      redirect_to :back
    end
  end

  def verify_user
    begin
      @member = Wcg.verify_user(@username, @verification_code)
    rescue => e
      false
    end
  end

  def registration
    @username = params.require(:username)
    @verification_code = params.require(:verification_code)
    @ripple_address = params.require(:ripple_address)
  end
end
