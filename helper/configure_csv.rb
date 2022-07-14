require 'pg'
require 'csv'
require_relative './database_connection'
require_relative './set_database'

class ConfigureCSV
  def self.hash_to_array
    table = SetDatabase.select_table
    @rows = []

    table.each do |row|
      hash_to_array = row.to_a.each {|data| data.shift }
      @rows << hash_to_array.map!{ |data| data.join("")}
    end

    return @rows
  end

  def self.get_header
    csv = CSV.read("./data.csv", col_sep: ';')
    @columns = csv.shift
    @columns << "id"

    return @columns
  end

  def self.array_to_json
    @rows.map do |row|
      row.each_with_object({}).with_index do |(cell, acc), idx|
        column = @columns[idx]
        acc[column] = cell
      end
    end.to_json
  end
end