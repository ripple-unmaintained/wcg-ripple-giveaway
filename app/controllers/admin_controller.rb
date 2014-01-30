class AdminController < ApplicationController
  http_basic_authenticate_with name: "ripple", password: ENV['BASIC_AUTH_PASSWORD']
end
