require 'pg'
require 'json'

module PetShopServer
  class CatsRepo

    def self.all db
      sql = %q[SELECT * FROM cats]
      result = db.exec(sql)
      JSON.generate(result.entries)
    end

    def self.get_cats_by_shop db, shopid
      sql = %q[SELECT * FROM cats WHERE shopid = $1]
      result = db.exec(sql, [shopid])
      JSON.generate(result.entries)
    end

     def self.find_by_owner_id db, ownerid
      sql = %q[SELECT * FROM cats WHERE owner_id = $1]
      result = db.exec(sql, [ownerid])
      result.entries
    end
  end
end