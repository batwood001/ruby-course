module PetShop
  class Dog < ActiveRecord::Base
    belongs_to :shop
    belongs_to :user
  end
end