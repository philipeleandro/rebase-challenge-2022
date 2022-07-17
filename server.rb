require 'sinatra'
require 'rack/handler/puma'
require 'csv'
require 'pg'
require_relative'./helper/list_csv_data'
require_relative  './helper/data_csv'
require 'sidekiq'
require 'sidekiq/web'
require 'redis'
load './sidekiq_worker/worker.rb'

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://redis:6379/0'}
end

get '/tests' do
  ListCSVData.set_database
end

post '/import' do
  MyWorker.perform_async(request.body.read)
  puts 'Seus dados estão sendo importados'
end

Rack::Handler::Puma.run(
  Sinatra::Application,
  Port: 3000,
  Host: '0.0.0.0'
)
