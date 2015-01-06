require 'active_record'
require 'active_record_tasks'
require_relative '../lib/pet-shop-server.rb' # the path to your application file... is this right???

ActiveRecord::Base.establish_connection(
  :adapter => 'postgresql',
  :database => 'pet-shop-server'
)