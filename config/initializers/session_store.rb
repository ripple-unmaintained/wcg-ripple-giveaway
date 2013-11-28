# Be sure to restart your server when you modify this file.

WcgGiveaway::Application.config.session_store :cookie_store,
											  key: '_wcg_giveaway_session',
											  expire_after: 30.days
