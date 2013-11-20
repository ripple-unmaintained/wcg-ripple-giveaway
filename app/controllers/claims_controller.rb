class ClaimsController < ApplicationController
  def update
  	claim = Claim.find(params[:claim_id])
  	claim.update_attributes({
  	  transaction_status: params[:transaction_status],
  	  transaction_hash: params[:transaction_hash]
  	})
  	render json: claim
  end
end
