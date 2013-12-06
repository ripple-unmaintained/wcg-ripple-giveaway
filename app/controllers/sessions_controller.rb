class SessionsController < ApplicationController
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