require 'pg'
require 'json'

module PetShopServer
  class ShopsRepo

    def self.all db
      sql = %q[SELECT * FROM shops]
      result = db.exec(sql)
      puts "ITS WORKINGNGNGNGNNGNGNGNGNGNN"
      JSON.generate(result.entries)
    end
  
  end
end