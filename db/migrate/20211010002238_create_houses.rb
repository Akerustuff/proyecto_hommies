# frozen_string_literal: true

class CreateHouses < ActiveRecord::Migration[5.2]
  def change
    create_table :houses do |t|
      t.string :name
      t.string :code

      t.timestamps
    end
  end
end
