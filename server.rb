require 'sinatra'
# require 'sinatra/reloader'
require 'rest-client'
require 'json'

require_relative 'lib/pet-shop-server.rb'

# class PetShopServer::Server < Sinatra::Application
  
  # configure do
    set :bind, '0.0.0.0'
    enable :sessions
  # end

  # before do
  #   if session['user_id']
  #     user_id = session['user_id']
  #     db = PetShopServer.create_db_connection 'pet-shop-server'
  #     @current_user = PetShopServer::UsersRepo.find db, user_id
  #   else
  #     @current_user = $sample_user
  #   end
  # end
# #
# This is our only html view...
#
  get '/' do
    if session[:user_id]
      # TODO: Grab user from database
      user_id = session[:user_id]
      db = PetShopServer.create_db_connection 'pet-shop-server'
      @current_user = PetShopServer::UsersRepo.find_by_id db, user_id
      @current_user[:cats] = PetShopServer::CatsRepo.find_by_owner_id db, user_id
      @current_user[:dogs] = PetShopServer::DogsRepo.find_by_owner_id db, user_id
      puts "CURRENT USER IS: #{@current_user}"
    # else
      # @current_user = $user
    end
    erb :index
  end

  # #
  # ...the rest are JSON endpoints
  #
  get '/shops' do
    headers['Content-Type'] = 'application/json'
    # RestClient.get("http://pet-shop.api.mks.io/shops")
    db = PetShopServer.create_db_connection('pet-shop-server')
    PetShopServer::ShopsRepo.all(db)
  end

  post '/signin' do
    params = JSON.parse request.body.read

    username = params['username']
    password = params['password']

    # TODO: Grab user by username from database and check password
    db = PetShopServer.create_db_connection('pet-shop-server')
    if PetShopServer::UsersRepo.find_by_name db, username
      user = PetShopServer::UsersRepo.find_by_name db, username #{ 'username' => 'alice', 'password' => '123' }
      # puts "-------------------------------"
      # puts user
      # puts "correct password: #{user['password']}"
      # puts "entered: #{password}"
      # puts "-------------------------------"
      if password == user['password']
        headers['Content-Type'] = 'application/json'
        # TODO: Return all pets adopted by this user
        # TODO: Set session[:user_id] so the server will remember this user has logged in
        session[:user_id] = user["id"]
        # $user.to_json
      else
        status 401
      end
    else
      status 401
    end
  end

   # # # #
  # Cats #
  # # # #
  get '/shops/:id/cats' do
    headers['Content-Type'] = 'application/json'
    id = params[:id]
    # TODO: Grab from database instead
    # puts RestClient.get("http://pet-shop.api.mks.io/shops/#{id}/cats")
    # RestClient.get("http://pet-shop.api.mks.io/shops/#{id}/cats")
    db = PetShopServer.create_db_connection('pet-shop-server')
    puts PetShopServer::CatsRepo.get_cats_by_shop(db, id)
    PetShopServer::CatsRepo.get_cats_by_shop(db, id)
  end

  put '/shops/:shop_id/cats/:id/adopt' do
    headers['Content-Type'] = 'application/json'
    shop_id = params[:shop_id]
    id = params[:id]
    # TODO: Grab from database instead
    RestClient.put("http://pet-shop.api.mks.io/shops/#{shop_id}/cats/#{id}",
      { adopted: true }, :content_type => 'application/json')
    # TODO (after you create users table): Attach new cat to logged in user
  end


   # # # #
  # Dogs #
  # # # #
  get '/shops/:id/dogs' do
    headers['Content-Type'] = 'application/json'
    id = params[:id]
    # TODO: Update database instead
    # RestClient.get("http://pet-shop.api.mks.io/shops/#{id}/dogs")
    db = PetShopServer.create_db_connection('pet-shop-server')
    puts PetShopServer::DogsRepo.get_dogs_by_shop(db, id)
    PetShopServer::DogsRepo.get_dogs_by_shop(db, id)
  end

  put '/shops/:shop_id/dogs/:id/adopt' do
    headers['Content-Type'] = 'application/json'
    shop_id = params[:shop_id]
    id = params[:id]
    # TODO: Update database instead
    RestClient.put("http://pet-shop.api.mks.io/shops/#{shop_id}/dogs/#{id}",
      { adopted: true }, :content_type => 'application/json')
    # TODO (after you create users table): Attach new dog to logged in user
  end


#   $sample_user = {
#     id: 999,
#     username: 'alice',
#     cats: [
#       { shopId: 1, name: "NaN Cat", imageUrl: "http://i.imgur.com/TOEskNX.jpg", adopted: true, id: 44 },
#       { shopId: 8, name: "Meowzer", imageUrl: "http://www.randomkittengenerator.com/images/cats/rotator.php", id: 8, adopted: "true" }
#     ],
#     dogs: [
#       { shopId: 1, name: "Leaf Pup", imageUrl: "http://i.imgur.com/kuSHji2.jpg", happiness: 2, id: 2, adopted: "true" }
#     ]
# }
# end
