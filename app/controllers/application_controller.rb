require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

helpers do
     def current_user
  @current_user ||= Trainer.find_by(id: session[:trainer_id]) if session[:trainer_id]

     end

     def logged_in?
       !!current_user
        #!!session[:user_id]
     end
    end
  end
