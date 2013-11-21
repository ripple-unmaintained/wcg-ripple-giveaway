class Api::ClaimsController < ApplicationController
  def update
  	claim_params = params.require(:transaction_status, :transaction_hash, :claim_id)
  	claim = Claim.find(claim_params[:claim_id])
  	claim.update_attributes(claim_params)
  	render json: claim
  end
end
