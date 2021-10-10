# frozen_string_literal: true

class AddFieldsToUser < ActiveRecord::Migration[5.2]
  def change
    change_table :users, bulk: true do |t|
      t.string :first_name
      t.string :last_name
      t.boolean :owner, default: false
    end
  end
end
