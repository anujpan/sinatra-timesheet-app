class UsersController < ApplicationController

  # Full user list
  get "/users" do
    @users = User.all
    
    erb :"/users/index.html"
  end

  # Signup page
  get "/signup" do
    if session[:user_id]
      @user = User.find_by(id: session[:user_id])
      redirect "/users/#{@user.username}"
    else
      erb :"/users/new.html"
    end
  end

  post "/signup" do
    @user = User.new(params)
    if !User.find_by(username: params[:username])
      @user.save
      session[:user_id] = @user.id
      redirect "/users/#{params[:username]}"
    else
      redirect "/signup"
    end
  end

  # Login page
  get "/login" do
    if session[:user_id]
      @user = User.find_by(id: session[:user_id])
      redirect "/users/#{@user.username}"
    else
      erb :"/users/login.html"
    end
  end

  post "/login" do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/users/#{@user.username}"
    else
      redirect '/login'
    end
  end

  # Sign Out
  get "/logout" do
    session.clear
    redirect "/"
  end

  # Show User Profile
  get "/users/:username" do
    @user = User.find_by(username: params[:username])
    
    if Helper.current_user(session).id == @user.id
      erb :"/users/show.html"
    else
      redirect '/'
    end
  end

  # DELETE User
  post "/users/:username/delete" do
    @user = User.find_by(username: params[:username])
    Log.where(user_id: @user.id).each do |l|
      l.destroy
    end
    @user.destroy
    redirect "/logout"
  end  
end
