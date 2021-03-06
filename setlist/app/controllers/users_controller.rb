class UsersController < ApplicationController

  # get '/users/:slug' do
  #   @user = User.find_by_slug(params[:slug])
  #   erb :'users/show'
  # end

  get '/users/:id' do
    if logged_in?
# binding.pry
      @user = User.find_by_id(params[:id])
      # @post = Post.find_by_id(params[:id])
      erb :'users/show'
    else
      redirect to '/login'
    end
  end

  get '/signup' do
    if !logged_in?
      erb :'users/new'
    else
      redirect to '/posts'
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect to '/signup'
    end
    
    if User.find_by(username: params[:username]) == nil
      @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect to '/posts'
    else
      redirect to '/signup'
    end
  end

  

  get '/login' do
    if !logged_in?
      erb :'users/login'
    else
      redirect to '/posts'
    end
  end

  post '/login' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to "/posts"
    else
      redirect to '/signup'
    end
  end

  get '/logout' do
    if logged_in?
      session.destroy
      redirect to '/login'
    else
      redirect to '/'
    end
  end




end