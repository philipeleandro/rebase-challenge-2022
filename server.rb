require 'sinatra'
require 'rack/handler/puma'
require 'csv'
require 'pg'
require './helper/database_connection'
require './helper/import_csv'

get '/tests' do
  ImportCSV.set_database
end

Rack::Handler::Puma.run(
  Sinatra::Application,
  Port: 3000,
  Host: '0.0.0.0'
)