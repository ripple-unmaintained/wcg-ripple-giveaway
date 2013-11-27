## Running the claimer on all users

A task will properly build and calculate new claims by calling `create_pending_claims`, `set_rate_for_claims`, `submit_pending_claims`.

    rake claims:calculate_rate_and_submit_for_payment

## Re-computing the Aggregate Stats

    rake update_aggregate_stats

## Processing Confirmed Claimsw

    rake claims:process_payment_confirmations

## Environment Variables

    PAYMENT_CONFIRMATIONS_QUEUE_NAME
    PAYMENT_REQUESTS_QUEUE_NAME
    AWS_ACCESS_KEY_ID
    AWS_SECRET_ACCESS_KEY
    REDISTOGO_URL
    HTTPARTY_TIMEOUT
    TEAM_ID
