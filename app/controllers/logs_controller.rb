class LogsController < ApplicationController

  # GET: /logs
  get "/logs" do
    @logs = Log.all
    if Helper.logged_in(session)
      erb :"/logs/index.html"
    else
      redirect '/'
    end
  end

  # GET: /logs/new
  get "/logs/new" do
    if Helper.logged_in(session)
      erb :"/logs/new.html"
    else
      redirect '/'
    end
  end

  # POST: /logs
  post "/logs" do
    @log = Log.new(params)
    @log.user = Helper.current_user(session)
    @log.save
    redirect "/logs"
  end

  # GET: /logs/5
  get "/logs/:id" do
    redirect "/logs"
  end

  # GET: /logs/5/edit
  get "/logs/:id/edit" do
    @log = Log.find_by(id: params[:id])
    if Helper.current_user(session).id == @log.user_id
      erb :"/logs/edit.html"
    else
      redirect '/logs'
    end
  end

  # PATCH: /logs/5
  patch "/logs/:id" do
    redirect "/logs/:id"
  end

  # DELETE: /logs/5/delete
  delete "/logs/:id/delete" do
    Log.find_by(id: params[:id]).destroy
    redirect "/logs"
  end
end
