require 'pg'

class Database
  def self.connect
    PG.connect(dbname: 'postgres', host: 'postgres', port: 5432, user: 'postgres', password: 'password')
  end
end