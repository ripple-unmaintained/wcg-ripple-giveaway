## Running the claimer on all users

A series of tasks will properly build and calculate new
claims

    rake create_pending_claims
    rake set_rate_for_claims
    rake submit_new_claims

## Re-computing the Aggregate Stats

    rake update_aggregate_stats

## Processing Confirmed Claimsw

    rake process_claim_payment_confirmations

## Environment Variables

    PAYMENT_CONFIRMATIONS_QUEUE_NAME
    PAYMENT_REQUESTS_QUEUE_NAME
    AWS_ACCESS_KEY_ID
    AWS_SECRET_ACCESS_KEY
    REDISTOGO_URL
    HTTPARTY_TIMEOUT
    TEAM_ID