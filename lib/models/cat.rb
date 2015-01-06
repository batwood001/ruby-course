module PetShop
  class Cat < ActiveRecord::Base
    belongs_to :shop
    belongs_to :user
  end
end