# frozen_string_literal: true

require 'pg'
require 'csv'
require_relative './database_connection'
require_relative './set_database'

# Set CSV to be redered
class ConfigureCSV
  def self.hash_to_array
    table = SetDatabase.select_table
    @rows = []

    table.each do |row|
      hash_to_array = row.to_a.each(&:shift)
      @rows << hash_to_array.map! { |data| data.join('') }
    end

    @rows
  end

  def self.set_header
    csv = CSV.read('./data.csv', col_sep: ';')
    @columns = csv.shift
    @columns << 'id'

    @columns
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
