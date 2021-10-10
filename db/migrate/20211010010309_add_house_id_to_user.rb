# frozen_string_literal: true

class AddHouseIdToUser < ActiveRecord::Migration[5.2]
  def change
    add_reference :users, :house, foreign_key: true
  end
end
