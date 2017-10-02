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
binding.pry
          @pokemon.save
          redirect to "/pokemon/:id"

      end


   	get '/pokemon/:id' do
   		if !logged_in?
   			redirect '/login'
   		end
   		#@trainer = Trainer.find_by_id(params[:id])
      @trainer = Trainer.find_by_id(current_user.id)
      @pokemons = Pokemon.all

   		erb :'pokemon/index'
   	end

    get '/pokemon/:id/edit' do
      if logged_in?
        @pokemons = Pokemon.all
        @pokemon = Pokemon.find_by_id(params[:id])
        if @pokemon.trainer_id == current_user.id
         erb :'pokemon/edit'
        else
          redirect to '/pokemon/:id'
        end
      else
        redirect to '/login'
      end
    end

    patch '/pokemon/:id' do
     if params[:name] == ""
       redirect to "/pokemon/#{params[:id]}/edit"
     else
       @pokemon = pokemon.find_by_id(params[:id])
       @pokemon.name = params[:name]
       @pokemon.type = params[:type]
       @pokemon.attacks = params[:attacks]
       @pokemon.save
       redirect to "/pokemon/#{@pokemon.id}"
     end
   end


   	delete '/pokemon/:id/delete' do
      @pokemons = Pokemon.all
   		@pokemon = @pokemons.find(params[:id])
      binding.pry
   		if !logged_in?
   			redirect to '/login'
   		elsif current_user.id == @pokemon.trainer_id
   			@pokemon.destroy
   		end

   		redirect to '/pokemon/:id'
   	end
   end
