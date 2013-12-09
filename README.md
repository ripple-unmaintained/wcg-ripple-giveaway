## Running the claimer on all users

A task will properly build and calculate new claims by calling `create_pending_claims`, `set_rate_for_claims`, `submit_pending_claims`.

    rake claims:calculate_rate_and_submit_for_payment

## Updating the total compute time

In order to ensure that every user has a fundable account we have decided to
give out a bonus equal to the `reserve amount` to every user when the attain
eight hours of computing. One time we need to set all the user's total_time
and funded status with the following rake task:

    rake set_initial_user_donated_time

After the initial task we will run another task daily to disburse the reserve
amount to everyone who has exceeded the eight hour threshold in the current period:

    rake update_user_donated_time_and_grant_bonuses

## Re-computing the Aggregate Stats

    rake update_aggregate_stats

## Processing Confirmed Claims

    rake claims:process_payment_confirmations

## Environment Variables

    PAYMENT_CONFIRMATIONS_QUEUE_NAME
    PAYMENT_REQUESTS_QUEUE_NAME
    AWS_ACCESS_KEY_ID
    AWS_SECRET_ACCESS_KEY
    REDISTOGO_URL
    HTTPARTY_TIMEOUT
    TEAM_ID
