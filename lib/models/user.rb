module PetShop
  class User < ActiveRecord::Base
    has_many :cats
    has_many :dogs
  end
end