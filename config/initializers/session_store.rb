# Be sure to restart your server when you modify this file.

# Rails.application.config.session_store :cookie_store, key: '_cherashev_session'

Cherashev::Application.config.session_store :redis_store, {
                                                           key: '_cherashev_session',
                                                           redis: {
                                                               host: 'localhost',
                                                               port: 6379,
                                                               db: 3,
                                                               namespace: 'session',
                                                               expires_in: 30.minutes,
                                                               key_prefix: 'cherashev:session:',
                                                           }
                                                       }
