# frozen_string_literal: true

require_relative 'set_database'

puts 'Starting process'
puts '-----------------------'
puts 'Droping existing table'
puts '-----------------------'
SetDatabase.drop_table
puts 'Creating table'
puts '-----------------------'
SetDatabase.create_table
puts 'Importing CSV data'
puts '-----------------------'
SetDatabase.data_to_database
puts 'Done'
