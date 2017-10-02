class PokemonController < ApplicationController

   	get '/pokemon' do
   		if logged_in?
        @pokemons = Pokemon.all
   			erb :'/pokemon/index'
   		else
   			redirect to '/login'
   		end
   	end

   	get '/pokemon/new' do
   		if logged_in?
        @pokemons = Pokemon.all
   			erb :'pokemon/create_pokemon'
   		else
   			redirect to '/login'
   		end
   	end

    post '/pokemon/new' do
          @pokemons = Pokemon.all
          @pokemon = Pokemon.new(name: params[:name],breed: params[:breed],attacks: params[:attacks], bio: params[:bio], photo: params[:photo])
          @pokemon.trainer_id = current_user.id
          @pokemon.save
          redirect to "/pokemon/home"

      end


   	get '/pokemon/home' do
   		if !logged_in?
   			redirect '/login'
   		end
   		#@trainer = Trainer.find_by_id(params[:id])
      @trainers = Trainer.all
      @trainer = @trainers.find_by_id(current_user.id)
      @pokemons = Pokemon.all

   		erb :'pokemon/index'
   	end

    get '/pokemon/:id/edit' do
      if logged_in?
        @pokemons = Pokemon.all
        @pokemon = @pokemons.find(params[:id])
        if current_user.id == @pokemon.trainer_id
         erb :'pokemon/edit_pokemon'
        else
          redirect to '/pokemon/home'
        end
      else
        redirect to '/login'
      end
    end

    patch '/pokemon/:id' do
       @pokemons = Pokemon.all
       @pokemon = @pokemons.find_by_id(params[:id])
       @pokemon.name = params[:name]
       @pokemon.save
       redirect to "/pokemon/home"

   end


   	delete '/pokemon/:id/delete' do
      @pokemons = Pokemon.all
   		@pokemon = @pokemons.find(params[:id])
   		if !logged_in?
   			redirect to '/login'
   		elsif current_user.id == @pokemon.trainer_id
   			@pokemon.destroy
   		end

   		redirect to '/pokemon/home'
   	end
   end
