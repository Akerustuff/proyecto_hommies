# frozen_string_literal: true

class FixColumnReviewerUserId < ActiveRecord::Migration[5.2]
  def change
    rename_column :tasks, :reviewer_user_id, :reviewer_id
  end
end
