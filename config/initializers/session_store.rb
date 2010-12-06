# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_bling_session',
  :secret      => '9b165bdf0ed2e179d3d24aff85572573b550d8b12527df10685d45962396f6a8bb3c4a1d1470ef8ad06ddd4edcbf30683715c0ba6a6e6c7334e41f060a3e4241'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
