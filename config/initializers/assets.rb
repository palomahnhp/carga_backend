# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

Rails.application.config.assets.precompile += %w( jquery-ui.css )
Rails.application.config.assets.precompile += %w( sweetalert2.min.css )
Rails.application.config.assets.precompile += %w( ajax-core.js )
Rails.application.config.assets.precompile += %w( html5shiv.js )
Rails.application.config.assets.precompile += %w( respond.js )
Rails.application.config.assets.precompile += %w( jquery.min.js )
Rails.application.config.assets.precompile += %w( bootstrap.min.js )
Rails.application.config.assets.precompile += %w( jquery-ui.js )
Rails.application.config.assets.precompile += %w( datepicker-es.js )
Rails.application.config.assets.precompile += %w( campaigns.js )
Rails.application.config.assets.precompile += %w( positions.js )
Rails.application.config.assets.precompile += %w( functions.js )
Rails.application.config.assets.precompile += %w( surveys.js )
Rails.application.config.assets.precompile += %w( units.js )
Rails.application.config.assets.precompile += %w( users.js )
Rails.application.config.assets.precompile += %w( sweetalert2.min.js )

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
