require 'pg'
require 'json'

module PetShopServer
  class DogsRepo

    def self.all db
      sql = %q[SELECT * FROM dogs]
      result = db.exec(sql)
      JSON.generate(result.entries)
    end

    def self.get_dogs_by_shop db, shopid
      sql = %q[SELECT * FROM dogs WHERE shopid = $1]
      result = db.exec(sql, [shopid])
      JSON.generate(result.entries)
    end

    def self.find_by_owner_id db, ownerid
      sql = %q[SELECT * FROM dogs WHERE owner_id = $1]
      result = db.exec(sql, [ownerid])
      result.entries
    end
  end
end