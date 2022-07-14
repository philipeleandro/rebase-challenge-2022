require 'spec_helper'
require 'pg'
require_relative '../helper/configure_csv'
require_relative '../helper/database_connection'

describe 'Configure CSV' do
  context 'get header from csv' do
    it { expect(ConfigureCSV.get_header).to include 'cpf' }
    it { expect(ConfigureCSV.get_header).to include 'nome paciente' }
    it { expect(ConfigureCSV.get_header).to include 'crm médico' }
    it { expect(ConfigureCSV.get_header).to include 'nome médico' }
  end

  it 'hash data into array' do
    SetDatabase.drop_table
    SetDatabase.create_table
    SetDatabase.select_table

    hash_data = ConfigureCSV.hash_to_array

    expect(hash_data).to be_an_instance_of(Array) 
    expect(hash_data).not_to include '{'
    expect(hash_data).not_to include '}'
  end 

  it 'array data into hash' do
    SetDatabase.drop_table
    SetDatabase.create_table
    SetDatabase.select_table
    Database.connect.exec_params("insert into patient(cpf, name, email, birthdate, address, city, state, crm, crm_state, doctor_name, 
                                  doctor_email, exam_result_token, exam_date, exam_type, exam_type_limit, exam_result) values 
                                  ('048.973.170-88','Emilly Batista Neto','gerald.crona@ebert-quigley.com','2001-03-11','165 Rua Rafaela',
                                  'Ituverava','Alagoas','B000BJ20J4','PI','Maria Luiza Pires','denna@wisozk.biz','IQCZ17','2021-08-05','hemácias',
                                  '45-52','97')")
    SetDatabase.select_table
    ConfigureCSV.hash_to_array
    ConfigureCSV.get_header

    expect(ConfigureCSV.array_to_json).to include '{'
    expect(ConfigureCSV.array_to_json).to include '}'
  end 
end