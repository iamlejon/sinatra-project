class CreateTrainers < ActiveRecord::Migration[5.1]
    def change
        create_table :trainers do |t|
          t.string :name
          t.string :username
          t.string :password_digest
          t.string :level
          t.string :photo
          t.text :bio
        end
    end
end
