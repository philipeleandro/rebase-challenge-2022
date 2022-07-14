require_relative './set_database'
require_relative './configure_csv'

class ImportCSV
  def self.set_database
    SetDatabase.drop_table
    SetDatabase.create_table
    SetDatabase.data_to_database
    SetDatabase.select_table
    ConfigureCSV.hash_to_array
    ConfigureCSV.get_header
    ConfigureCSV.array_to_json
  end
end