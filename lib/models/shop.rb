module PetShop
  class Shop < ActiveRecord::Base
    has_many :dog
    has_many :cat
  end
end