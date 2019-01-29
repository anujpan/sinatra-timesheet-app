class UsersController < ApplicationController

  # Full user list
  get "/users" do
    erb :"/users/index.html"
  end

  # Signup page
  get "/signup" do
    erb :"/users/new.html"
  end

  # Post signup
  post "/signup" do
    redirect "/users"
  end

  # Login page
  get "/login" do
    erb :"/users/login.html"
  end

  # Post login
  post "/login" do
    redirect "/users"
  end

  # Sign Out
  get "/logout" do
    redirect "/login"
  end

  # Show User Profile
  get "/users/:id" do
    erb :"/users/show.html"
  end

  # Edit User Profile
  get "/users/:id/edit" do
    erb :"/users/edit.html"
  end

  # PATCH edit to User Profile
  patch "/users/:id" do
    redirect "/users/:id"
  end

  # DELETE User
  delete "/users/:id/delete" do
    redirect "/users"
  end
end
