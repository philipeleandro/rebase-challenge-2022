# frozen_string_literal: true

require_relative './set_database'
require_relative './configure_csv'

# Render CSV
class ListCSVData
  def self.set_database
    SetDatabase.create_table
    SetDatabase.select_table
    ConfigureCSV.hash_to_array
    ConfigureCSV.set_header
    ConfigureCSV.array_to_json
  end
end
