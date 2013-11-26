class WcgServiceUnavailable < Exception; end

class ApplicationController < ActionController::Base
  rescue_from WcgServiceUnavailable, with: :service_unavailable

  def service_unavailable
    render json: { error: 'service unavailable' }
  end

end


