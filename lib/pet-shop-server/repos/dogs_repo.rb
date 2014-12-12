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
  end
end