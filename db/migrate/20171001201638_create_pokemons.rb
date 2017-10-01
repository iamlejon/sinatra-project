class CreatePokemons < ActiveRecord::Migration[5.1]
    def change
      create_table :pokemons do |t|
        t.string :name
        t.string :type
        t.string :attacks
        t.integer :trainer_id
		    t.string :photo
		    t.text :bio
      end
    end
  end
