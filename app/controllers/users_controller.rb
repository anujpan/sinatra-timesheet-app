class UsersController < ApplicationController

  # Full user list
  get "/users" do
    erb :"/users/index.html"
  end

  # Signup page
  get "/signup" do
    if session[:user_id]
      @user = User.find_by(id: session[:user_id])
      redirect "/users/#{@user.username}"
    else
      @session = session
      erb :"/users/new.html"  
    end
  end

  post "/signup" do
    @user = User.new(params)
    if @user.save
      session[:user_id] = @user.id
      redirect "/users/#{params[:username]}"
    else
      redirect "/signup"
    end
  end

  # Login page
  get "/login" do
    erb :"/users/login.html"
  end

  post "/login" do
    redirect "/users/:id"
  end

  # Sign Out
  get "/logout" do
    session.clear
    redirect "/"
  end

  # Show User Profile
  get "/users/:username" do
    @user = User.find_by(username: params[:username])
    erb :"/users/show.html"
  end

  # Edit User Profile
  get "/users/:id/edit" do
    erb :"/users/edit.html"
  end

  patch "/users/:id" do
    redirect "/users/:id"
  end

  # DELETE User
  delete "/users/:id/delete" do
    redirect "/users"
  end
end
