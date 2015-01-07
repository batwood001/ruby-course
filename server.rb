require 'sinatra'
# require 'sinatra/reloader'
require 'rest-client'
require 'json'
require 'sinatra/flash'

require_relative 'config/environments.rb'


    set :bind, '0.0.0.0'
    enable :sessions


  get '/' do
    if session[:user_id]
      user_id = session[:user_id]
      @current_user = PetShop::User.find(user_id)
      puts "CURRENT USER IS: #{@current_user}"
      erb :index
    else
      redirect to '/signup'
    end
    # erb :index
  end

  get '/signup' do
    erb :signup
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

    if PetShop::User.find_by username: username
      user = PetShop::User.find_by username: username #{ 'username' => 'alice', 'password' => '123' }
      if password == user.attributes['password']
        headers['Content-Type'] = 'application/json'
        session[:user_id] = user.attributes["id"]
      else
        status 401
      end
    else
      status 401
    end
  end

  post '/signup' do
    # params = JSON.parse request.body.read

    username = params['username']
    password = params['password']

    if PetShop::User.find_by username: username
      status 401
    else
      user = PetShop::User.create(username: username, password: password)
      unless user.attributes["id"] === nil
        # user = PetShop::User.find_by username: username
        puts "user: #{user}"
        puts "user attributes: #{user.attributes}"
        puts "user.errors: #{user.errors.to_a}"
        session[:user_id] = user.attributes["id"]
        redirect to '/'
      else
        flash[:error1] = user.errors.to_a[0]
        flash[:error2] = user.errors.to_a[1]
        flash[:error3] = user.errors.to_a[2]
        # flash[:error]
        redirect to '/signup'
      end
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
    cat = PetShop::Cat.find_by(id: id)
    cat.update(adopted: true)
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
    dog = PetShop::Dog.find_by(id: id)
    dog.update(adopted: true)
    # TODO (after you create users table): Attach new dog to logged in user
  end

