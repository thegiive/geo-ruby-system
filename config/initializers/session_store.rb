# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_georails_session',
  :secret      => '1d45fa36a15d6eb43fa3c818bd1f2221f463b20288e29bf98a57631b83047c3d3a6bdf223d6ce6072288d361abd4148665768531fe5c932e96e4713c8fc53299'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
