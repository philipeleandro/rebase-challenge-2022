# frozen_string_literal: true

require_relative 'set_database'

SetDatabase.drop_table
SetDatabase.create_table
SetDatabase.data_to_database
