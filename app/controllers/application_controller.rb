class ApplicationController < ActionController::Base
  rescue_from Wcg::ServiceUnavailable, with: :service_unavailable
  rescue_from ActionController::ParameterMissing, with: lambda {|e| parameter_missing(e) }
  rescue_from Wcg::InvalidUserNameOrVerificationCode, with: :invalid_username_or_verification

  def service_unavailable
    flash[:alert] = "WCG is currently unavailable for their stats update. Please register in a few hours"
    redirect_to :back
  end

  def parameter_missing(error)
    render json: { error: error }
  end

  def invalid_username_or_verification
    flash[:notice] = { username: 'username does not match verification code' }
    redirect_to :back
  end

  def index
    @total_xrp = REDIS.get("total_xrp")
    @total_hours = REDIS.get("total_hours") 
    @xrp_today = ENV['NEXT_XRP_CLAIM_TOTAL']
  end
end
