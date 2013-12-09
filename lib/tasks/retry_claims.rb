task update_failed_claims_that_actually_succeeded: :environment do
  JSON.parse(STDIN.read).each do |claim|
    begin
      claim = Claim.find(claim)
      claim.transaction_status = 'tesSUCCESS'
      claim.save
      puts 'claim updated'
    rescue
      puts 'claim not found'
    end
  end
end