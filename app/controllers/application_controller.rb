class ApplicationController < ActionController::Base
  rescue_from Wcg::ServiceUnavailable, with: :service_unavailable

  def service_unavailable
    render json: { error: 'service unavailable' }
  end
end


