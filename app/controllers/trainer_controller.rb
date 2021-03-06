class TrainersController < ApplicationController


  #displays the user signup
  #only shows the sign-up page if user is not logged in if they are logged in, redirects them to their tweets
    get "/" do
        if !logged_in?
          erb :"index"
        else
          redirect '/pokemon/home'
        end
    end

  #Trainers submission form is loaded via the POST request to /signup
    post "/signup" do
        if params[:username]== "" || params[:name]== "" || params[:password]== "" || params[:photo]== ""
          redirect '/'
        else
          @trainer = Trainer.new(name: params[:name], username: params[:username], password: params[:password], photo: params[:photo])
        end

        if @trainer.save
           @trainer.save
          session[:trainer_id] = @trainer.id
          redirect to "/pokemon/home"
        else
          erb :'index', locals: {message: "USERNAME ALREADY EXISTS! Please choose new username"}
        end
     end

  #renders the login page for a user
  #doesn't let user view the login page if already logged in"
    get "/login" do
        if logged_in?
          redirect "/pokemon/home"
        else
          erb :'/trainers/login'
        end
    end

  #login form is loaded via post /login request
    post "/login" do
        trainer = Trainer.find_by(:username => params[:username])
        if trainer && trainer.authenticate(params[:password])
            session[:trainer_id] = trainer.id
            redirect to "/pokemon/home"
        else
            erb :'/trainers/login', locals: {message: "Please login with valid username/password before continuing"}
        end
    end

    get '/trainer/:id/edit' do
        if logged_in?
          @trainers = Trainer.all
          @trainer = @trainers.find(params[:id])
            if current_user.id == @trainer.id
              erb :'/trainers/edit_trainer'
            else
              redirect to '/pokemon/home'
            end
        else
          redirect to '/login'
        end
    end

    patch '/trainer/:id' do
       @trainers = Trainer.all
       @trainer = @trainers.find_by_id(params[:id])
       @trainer.name = params[:name]
       @trainer.bio = params[:bio]
       @trainer.save
       redirect to "/pokemon/home"
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
