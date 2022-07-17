require 'csv'

class DataCSV
  def self.insert_data(csv_file)
    rows_csv = CSV.parse(csv_file)

    rows_csv.each.with_index do |row, index|
      data = row[0].split(';')

      if index != 0
        Database.connect.exec_params("insert into patient(cpf, name, email, birthdate, address, city, state, crm, crm_state,
          doctor_name, doctor_email, exam_result_token, exam_date, exam_type, exam_type_limit, 
          exam_result) values ('#{data[0]}', '#{data[1]}', '#{data[2]}', '#{data[3]}', '#{data[4]}', 
          '#{data[5]}', '#{data[6]}', '#{data[7]}', '#{data[8]}', '#{data[9]}', '#{data[10]}', '#{data[11]}', 
          '#{data[12]}', '#{data[13]}', '#{data[14]}', '#{data[15]}');")
      end
    end
  end
end