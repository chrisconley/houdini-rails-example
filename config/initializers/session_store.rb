# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_houdini_rails_example_session',
  :secret      => 'e6d6a271c83fdb6607e34f97aea3bb176700f3dc9fa155c29152285cd7e69ea1dc3ecadc9a582a520aa1f7a46385721f4069cfdc735f53a9de5abfb1357f6e19'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
