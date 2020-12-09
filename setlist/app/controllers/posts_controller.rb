class PostsController < ApplicationController

  get '/posts' do
    if logged_in?
      @posts = Post.all
  #     @posts.sort_by { |post| [post.artist] }
  # binding.pry
      erb :'posts/index'
    else
      redirect to '/login'
    end
  end

  get '/posts/new' do
    if logged_in?
      erb :'posts/new'
    else
      redirect to '/login'
    end
  end

  post '/posts' do
    if logged_in?
      if params[:content] == ""
        redirect to "/posts/new"
      else
        @post = current_user.posts.build(title: params[:title], artist: params[:artist], difficulty: params[:difficulty], content: params[:content])
        if @post.save
          redirect to "/posts/#{@post.id}"
        else
          redirect to "/posts/new"
        end
      end
    else
      redirect to '/login'
    end
  end

  get '/posts/:id' do
    if logged_in?
      @post = Post.find_by_id(params[:id])
      erb :'posts/show'
    else
      redirect to '/login'
    end
  end

  get '/posts/:id/edit' do
    if logged_in?
      @post = Post.find_by_id(params[:id])
      if @post && @post.user == current_user
        erb :'posts/edit'
      else
        redirect to '/posts'
      end
    else
      redirect to '/login'
    end
  end

  patch '/posts/:id' do
    if logged_in?
      if params[:content] == ""
        redirect to "/posts/#{params[:id]}/edit"
      else
        @post = Post.find_by_id(params[:id])
        if @post && @post.user == current_user
          if @post.update(content: params[:content])
            redirect to "/posts/#{@post.id}"
          else
            redirect to "/posts/#{@post.id}/edit"
          end
        else
          redirect to '/posts'
        end
      end
    else
      redirect to '/login'
    end
  end
  delete '/posts/:id/delete' do
    if logged_in?
      @post = Post.find_by_id(params[:id])
      if @post && @post.user == current_user
        @post.delete
      end
      redirect to '/posts'
    else
      redirect to '/login'
    end
  end



end