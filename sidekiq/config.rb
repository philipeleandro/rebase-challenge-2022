# frozen_string_literal: true

require 'sidekiq'
require_relative '../sidekiq_worker/worker'

Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://redis:6379/0' }
end

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://redis:6379/0' }
end
