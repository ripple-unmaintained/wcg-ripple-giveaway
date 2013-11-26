class WcgApi
  include HTTParty
  default_timeout ENV['HTTPARTY_TIMEOUT'].to_i
end