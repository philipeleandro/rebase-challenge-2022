require 'spec_helper'
require 'pg'
require_relative '../helper/set_database'
require_relative '../helper/database_connection'

describe 'Database' do
  it 'select data table' do
    SetDatabase.drop_table
    SetDatabase.create_table
   
    expect(Database.connect.exec_params('select * from patient').count).to eq 0
  end

  it 'create a table' do
    SetDatabase.drop_table
    SetDatabase.create_table
    table_names = []

    Database.connect.exec("select table_name from information_schema.tables where table_schema='public'") do |result|
      result.each do |hash_names|
        hash_names.to_a.each do |name|
          table_names << name.last
        end
      end
    end

    expect(table_names).to include 'patient'
  end

  it 'drop a table' do
    SetDatabase.drop_table
    SetDatabase.create_table
    SetDatabase.drop_table
    table_names = []

    Database.connect.exec("select table_name from information_schema.tables where table_schema='public'") do |result|
      result.each do |hash_names|
        hash_names.to_a.each do |name|
          table_names << name.last
        end
      end
    end

    expect(table_names).not_to include 'patient'
  end
end