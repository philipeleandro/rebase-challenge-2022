# frozen_string_literal: true

require 'spec_helper'
require_relative '../helper/details_exams'
require_relative '../helper/data_csv'
require_relative '../helper/set_database'
require_relative '../helper/database_connection'

describe 'Filtered data tests' do
  it 'Returns exams data' do
    SetDatabase.drop_table
    SetDatabase.create_table
    Database.connect.exec_params("insert into patient(cpf, name, email, birthdate, address, city,
                                state, crm, crm_state, doctor_name, doctor_email, exam_result_token,
                                exam_date, exam_type, exam_type_limit, exam_result) values
                                ('048.973.170-88','Emilly Batista Neto','gerald.crona@ebert-quigley.com',
                                '2001-03-11', '165 Rua Rafaela','Ituverava','Alagoas','B000BJ20J4','PI',
                                'Maria Luiza Pires','denna@wisozk.biz','IQCZ17','2021-08-05','hemácias',
                                '45-52','97')")

    expect(DetailsExams.filtered_data_tests('IQCZ17').count).to eq 1
  end

  it 'Returns patient doctor' do
    SetDatabase.drop_table
    SetDatabase.create_table
    Database.connect.exec_params("insert into patient(cpf, name, email, birthdate, address, city,
                                state, crm, crm_state, doctor_name, doctor_email, exam_result_token,
                                exam_date, exam_type, exam_type_limit, exam_result) values
                                ('048.973.170-88','Emilly Batista Neto','gerald.crona@ebert-quigley.com',
                                '2001-03-11', '165 Rua Rafaela','Ituverava','Alagoas','B000BJ20J4','PI',
                                'Maria Luiza Pires','denna@wisozk.biz','IQCZ17','2021-08-05','hemácias',
                                '45-52','97')")

    expect(DetailsExams.filtered_data_doctor('IQCZ17').first['crm']).to eq 'B000BJ20J4'
    expect(DetailsExams.filtered_data_doctor('IQCZ17').first['crm_state']).to eq 'PI'
    expect(DetailsExams.filtered_data_doctor('IQCZ17').first['doctor_name']).to eq 'Maria Luiza Pires'
  end

  it 'Rerturns exams data' do
    SetDatabase.drop_table
    SetDatabase.create_table
    Database.connect.exec_params("insert into patient(cpf, name, email, birthdate, address, city,
                                state, crm, crm_state, doctor_name, doctor_email, exam_result_token,
                                exam_date, exam_type, exam_type_limit, exam_result) values
                                ('048.973.170-88','Emilly Batista Neto','gerald.crona@ebert-quigley.com',
                                '2001-03-11', '165 Rua Rafaela','Ituverava','Alagoas','B000BJ20J4','PI',
                                'Maria Luiza Pires','denna@wisozk.biz','IQCZ17','2021-08-05','hemácias',
                                '45-52','97')")

    expect(DetailsExams.filtered_data_tests('IQCZ17').count).to eq 1
  end

  it 'return all data merged' do
    SetDatabase.drop_table
    SetDatabase.create_table
    Database.connect.exec_params("insert into patient(cpf, name, email, birthdate, address, city,
                                state, crm, crm_state, doctor_name, doctor_email, exam_result_token,
                                exam_date, exam_type, exam_type_limit, exam_result) values
                                ('048.973.170-88','Emilly Batista Neto','gerald.crona@ebert-quigley.com',
                                '2001-03-11', '165 Rua Rafaela','Ituverava','Alagoas','B000BJ20J4','PI',
                                'Maria Luiza Pires','denna@wisozk.biz','IQCZ17','2021-08-05','hemácias',
                                '45-52','97')")

    expect(DetailsExams.mix_data('IQCZ17')['exam_result_token']).to eq 'IQCZ17'
    expect(DetailsExams.mix_data('IQCZ17')['cpf']).to eq '048.973.170-88'
    expect(DetailsExams.mix_data('IQCZ17')['doctor']['crm']).to eq 'B000BJ20J4'
    expect(DetailsExams.mix_data('IQCZ17')['doctor'].count).to eq 3
    expect(DetailsExams.mix_data('IQCZ17')).to be_an_instance_of(Hash)
  end
end
