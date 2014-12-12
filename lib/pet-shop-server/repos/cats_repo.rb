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
  end
end