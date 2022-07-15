require 'spec_helper'
require 'pg'
require 'csv'
require_relative '../helper/database_connection'
require_relative '../helper/set_database'
require_relative '../helper/data_csv'

describe 'Data to CSV' do
  it 'insert data into database' do
    SetDatabase.drop_table
    SetDatabase.create_table
    file = ['cpf; name; email; birthdate; address; city; state; crm; crm_state; doctor_name; doctor_email; exam_result_token;
           exam_date; exam_type; exam_type_limit; exam_result','048.973.170-88;Emilly Batista Neto;gerald.crona@ebert-quigley.com;
           2001-03-11;165 Rua Rafaela;Ituverava;Alagoas;B000BJ20J4;PI;Maria Luiza Pires;denna@wisozk.biz;IQCZ17;2021-08-05;hemácias;
           45-52;97\n']

    DataCSV.insert_data(file)
    
    expect(Database.connect.exec_params('select * from patient').count).to eq 1
  end
end