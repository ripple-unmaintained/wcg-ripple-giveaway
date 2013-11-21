class SessionsController < ApplicationController
  def create
    if (user = Wcg.verify_user(params[:username], params[:verification_code]))
      session[:user] = user
      redirect_to '/my-stats'
    else
      redirect_to :back
    end
  end

  def new
    if session[:user]
      redirect_to '/my-stats'
    end
  end

  def destroy
    reset_session
    redirect_to '/'
  end
end