class AdminController < ApplicationController
  http_basic_authenticate_with name: "ripple", password: "r!ppl3l@b5"
end
