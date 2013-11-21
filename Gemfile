source 'https://rubygems.org'

gem 'rails', '4.0.1'
gem 'nokogiri'
gem 'httparty'
gem 'redis'
gem 'aws-sdk'
gem 'ripple_lib_rpc_ruby', github: 'stevenzeiler/ripple-lib-rpc-ruby'
gem 'pg'

# Heroku requires logs to be streamed to STDOUT, this gem does that
group :production do
  gem 'rails_12factor'
end

group :development do
  gem 'pry'
end
