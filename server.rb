require 'sinatra'
# require 'sinatra/reloader'
require 'rest-client'
require 'json'

require_relative 'config/environments.rb'


    set :bind, '0.0.0.0'
    enable :sessions


  get '/' do
    if session[:user_id]
      user_id = session[:user_id]
      @current_user = PetShop::User.find(user_id)
      puts "CURRENT USER IS: #{@current_user}"
    end
    erb :index
  end

  # #
  # ...the rest are JSON endpoints
  #
  get '/shops' do
    headers['Content-Type'] = 'application/json'
    PetShop::Shop.all.to_json
  end

  post '/signin' do
    params = JSON.parse request.body.read

    username = params['username']
    password = params['password']

    # TODO: Grab user by username from database and check password
    # db = PetShopServer.create_db_connection('pet-shop-server')
    # if PetShopServer::UsersRepo.find_by_name db, username
    if PetShop::User.find(username)
      user = PetShop::User.find(username) #{ 'username' => 'alice', 'password' => '123' }
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
    PetShop::Cat.where(shopid: id).to_json
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
    PetShop::Dog.where(shopid: id).to_json
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

