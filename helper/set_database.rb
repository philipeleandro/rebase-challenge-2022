# frozen_string_literal: true

require 'pg'
require 'csv'
require_relative './database_connection'

# Queries
class SetDatabase
  @connection = Database.connect

  def self.drop_table
    @connection.exec('drop table if exists patient;')
  end

  def self.create_table
    @connection.exec("create table if not exists patient (cpf varchar NOT NULL, name varchar NOT NULL,
      email varchar NOT NULL, birthdate varchar NOT NULL, address varchar NOT NULL, city varchar NOT NULL,
      state varchar NOT NULL, crm varchar NOT NULL, crm_state varchar NOT NULL, doctor_name varchar NOT NULL,
      doctor_email varchar NOT NULL, exam_result_token varchar NOT NULL, exam_date varchar NOT NULL,
      exam_type varchar NOT NULL, exam_type_limit varchar NOT NULL, exam_result varchar NOT NULL,
      ID SERIAL PRIMARY KEY )")
  end

  def self.data_to_database
    CSV.foreach('./data.csv').with_index do |row, index|
      if index != 0
        row.each_with_index do |single_row, _index|
          data = single_row.split(';')

          @connection.exec_params("insert into patient(cpf, name, email, birthdate, address, city, state, crm,
                                  crm_state, doctor_name, doctor_email, exam_result_token, exam_date, exam_type,
                                  exam_type_limit, exam_result) values ('#{data[0]}', '#{data[1]}', '#{data[2]}',
                                  '#{data[3]}', '#{data[4]}', '#{data[5]}', '#{data[6]}', '#{data[7]}',
                                  '#{data[8]}', '#{data[9]}', '#{data[10]}', '#{data[11]}', '#{data[12]}',
                                  '#{data[13]}', '#{data[14]}', '#{data[15]}');")
        end
      end
    end
  end

  def self.select_table
    @connection.exec_params('select * from patient')
  end
end
