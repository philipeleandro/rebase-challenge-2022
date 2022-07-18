require 'pg'
require_relative 'database_connection.rb'

class DetailsExams
  @connect = Database.connect

  def self.filtered_data_tests(token)
    @connect.exec_params("select exam_type, exam_type_limit, exam_result from patient where exam_result_token = '#{token}'").to_a
  end

  def self.filtered_data_doctor(token)
    @connect.exec_params("select distinct crm, crm_state, doctor_name from patient where exam_result_token = '#{token}'").to_a
  end


  def self.filtered_data_patient(token)
    @connect.exec_params("select distinct exam_result_token, exam_date, cpf, name, email, birthdate from patient where exam_result_token = '#{token}'").to_a
  end

  def self.mix_data(token)
    tests = filtered_data_tests(token)
    doctor = filtered_data_doctor(token)
    patient = filtered_data_patient(token)

    result = patient.first
    result = result.merge('doctor' => doctor.first)
    result = result.merge('tests' => tests)
    
    return result
  end
end