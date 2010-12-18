# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_css_session',
  :secret      => '42cd06d4f3bafb1ab7e4dd8e862df592baf2df4da529e597054b167cb74e35e6945960377599c84201df25cbf0a459e9f81117186837278f83e4af3a2dd3bf7c'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
