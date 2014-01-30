# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
WcgGiveaway::Application.config.secret_key_base = ENV['SECRET_KEY_BASE'] || '4288377139599e6f0eb9fb955c2cd4d98d93078dde001b97a78de8c16d27b533fb0b8f9aecf1e57683bf36d6ccd59225a085aba073b4ba982db9c796d63018a5'
