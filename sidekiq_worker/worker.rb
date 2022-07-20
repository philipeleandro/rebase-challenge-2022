# frozen_string_literal: true

require 'sidekiq'
require_relative '../helper/set_database'
require_relative '../helper/data_csv'

# Job
class MyWorker
  include Sidekiq::Worker

  def perform(csv_data)
    SetDatabase.drop_table
    SetDatabase.create_table
    DataCSV.insert_data(csv_data)
  end
end
