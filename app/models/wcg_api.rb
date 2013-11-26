class WcgApi
  include HTTParty
  default_timeout ENV['HTTPARTY_TIMEOUT']
end