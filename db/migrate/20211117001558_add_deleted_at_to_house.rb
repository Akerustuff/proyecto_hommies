# frozen_string_literal: true

class AddDeletedAtToHouse < ActiveRecord::Migration[5.2]
  def change
    add_column :houses, :deleted_at, :datetime
    add_index :houses, :deleted_at
  end
end
