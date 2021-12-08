# frozen_string_literal: true

class FixColumnOwnerUserId < ActiveRecord::Migration[5.2]
  def change
    rename_column :tasks, :owner_user_id, :owner_id
  end
end
