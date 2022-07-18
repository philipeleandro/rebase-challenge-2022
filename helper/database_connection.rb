require 'pg'

class Database
  def self.connect
    PG.connect(dbname: 'postgres', host: '172.19.0.3', port: 5432, user: 'postgres', password: 'password')
  end
end