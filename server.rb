require 'sinatra'
require 'rack/handler/puma'
require 'csv'
require 'pg'
require './helper/list_csv_data'
require './helper/data_csv'

get '/tests' do
  ListCSVData.set_database
end

post '/import' do
  SetDatabase.drop_table
  SetDatabase.create_table
  DataCSV.insert_data(request.body)
end

Rack::Handler::Puma.run(
  Sinatra::Application,
  Port: 3000,
  Host: '0.0.0.0'
)