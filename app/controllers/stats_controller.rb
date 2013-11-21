class StatsController < ApplicationController
  def show
  	if !session[:user]
  	  redirect_to '/login'
  	end
  end
end