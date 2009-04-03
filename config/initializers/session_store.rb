# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_mydailyme_session',
  :secret      => 'a0d0ab5539d87c66c4b3ee1595be40c52e4e5d022cda5acb43d5ca0d3704ce9447e21a810a0a014481dd0138986f4ff1c85b07be381173f5edc8006370f989ae',
  :expire_after => 120.minutes
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
