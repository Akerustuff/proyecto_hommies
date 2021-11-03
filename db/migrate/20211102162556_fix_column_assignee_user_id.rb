# frozen_string_literal: true

class FixColumnAssigneeUserId < ActiveRecord::Migration[5.2]
  def change
    rename_column :tasks, :assignee_user_id, :assignee_id
  end
end
