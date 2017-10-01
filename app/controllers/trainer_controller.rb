class TrainersController < ApplicationController


  #displays the user signup
  #only shows the sign-up page if user is not logged in if they are logged in, redirects them to their tweets
    get "/" do
    if !logged_in?
      erb :"index"
    else
      redirect '/pokemon/:id'
    end
  end

  #Trainers submission form is loaded via the POST request to /signup
    post "/" do
      if params[:username]== "" || params[:name]== "" || params[:password]== "" || params[:photo]== ""
       redirect '/'
     else
      @trainer = Trainer.new(name: params[:name], username: params[:username], password: params[:password], photo: params[:photo])
      binding.pry
    end
      if @trainer.save
        @trainer.save
        session[:trainer_id] = @trainer.id
        redirect to "/pokemon/:id"
      else
      erb :'index', locals: {message: "USERNAME ALREADY EXISTS! Please choose new username"}
    end
  end

  #renders the login page for a user
  #doesn't let user view the login page if already logged in"
    get "/login" do
      if logged_in?
      redirect "/pokemon/:id"
    else
      erb :'/trainers/index'
      end
    end

  #login form is loaded via post /login request
    post "/login" do
      trainer = Trainer.find_by(:username => params[:username])
      binding.pry
      if trainer && trainer.authenticate(params[:password])
          session[:trainer_id] = trainer.id
          redirect to "/pokemon/:id"
      else
          redirect "index"
      end
    end

    get '/logout' do
       if logged_in?
         session.destroy
         redirect '/login'
       else
         redirect '/'
       end
     end

  end #ends class
