class PokemonController < ApplicationController

   	get '/pokemon' do
   		if logged_in?
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
          @pokemon = Pokemon.new(name: params[:name],type: params[:type],attacks: params[:attacks])
binding.pry
          @pokemon.save
          redirect to "/pokemon/#{@pokemon.id}"

      end


   	get '/pokemon/:id' do
   		if !logged_in?
   			redirect '/login'
   		end
   		#@trainer = Trainer.find_by_id(params[:id])
      @trainer = Trainer.find_by_id(current_user.id)

   		erb :'pokemon/index'
   	end

    get '/pokemon/:id/edit' do
      if logged_in?
        @pokemon = Pokemon.find_by_id(params[:id])
        if @pokemon.user_id == current_user.id
         erb :'pokemon/edit'
        else
          redirect to '/pokemon'
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
   		@pokemon = pokemon.find(params[:id])
   		if !logged_in?
   			redirect to '/login'
   		elsif current_user.pokemons.include?(@pokemon)
   			pokemon.find(params[:id]).destroy
   		end

   		redirect to '/pokemon'
   	end
   end
