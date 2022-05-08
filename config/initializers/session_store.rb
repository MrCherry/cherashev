# Be sure to restart your server when you modify this file.

# Rails.application.config.session_store :cookie_store, key: '_cherashev_session'

Rails.application.config.session_store :redis_store,
  servers: [Rails.configuration.redis.merge(namespace: "session")],
  expire_after: 90.minutes,
  key: "_#{Rails.application.class.parent_name.downcase}_session"
