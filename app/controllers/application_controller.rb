class ApplicationController < ActionController::Base
  rescue_from Wcg::ServiceUnavailable, with: :service_unavailable
  rescue_from ActionController::ParameterMissing, with: lambda {|e| parameter_missing(e) }
  rescue_from Wcg::InvalidUserNameOrVerificationCode, with: :invalid_username_or_verification

  def service_unavailable
    render json: { error: 'service unavailable' }
  end

  def parameter_missing(error)
    render json: { error: error }
  end

  def invalid_username_or_verification
    render json: { error: 'username does not match verification code' }
  end
end