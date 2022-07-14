require 'spec_helper'
require 'pg'
require_relative '../helper/import_csv'
require_relative '../helper/database_connection'

describe 'Import CSV methods' do
  it 'connect database, create table and insert csv data' do
    # Take a few minutes
    ImportCSV.set_database

    expect(Database.connect.exec_params('select * from patient').count).to eq 3900
  end
end