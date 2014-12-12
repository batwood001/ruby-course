require 'pg'
require 'json'

module PetShopServer
  class UsersRepo

    def self.all db
      sql = %q[SELECT * FROM users]
      result = db.exec(sql)
      JSON.generate(result.entries)
    end

    def self.find_by_name db, name
      sql = %q[SELECT * FROM users where username = $1]
      result = db.exec(sql, [name])
      result.entries.first
    end
  
  end
end