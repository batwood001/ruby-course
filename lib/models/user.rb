module PetShop
  class User < ActiveRecord::Base
    has_many :cats
    has_many :dogs
    validates :username, length: { minimum: 4 }
    validates :username, length: { maximum: 12 }
    validates :password, length: { minimum: 6 }
    validates :password, format: { with: /[a-zA-Z]+[0-9]+|[0-9]+[a-zA-Z]+/, message: "Must have both letters and numbers"}
  end
end