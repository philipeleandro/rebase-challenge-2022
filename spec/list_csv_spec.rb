# frozen_string_literal: true

require 'spec_helper'
require 'pg'
require_relative '../helper/list_csv_data'
require_relative '../helper/database_connection'
require_relative '../helper/set_database'

describe 'Import CSV methods' do
  it 'connect database, create table' do
    SetDatabase.drop_table
    ListCSVData.set_database

    expect(Database.connect.exec_params('select * from patient').count).to eq 0
  end
end
