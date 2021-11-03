# frozen_string_literal: true

class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :name
      t.text :description
      t.integer :category
      t.date :limit_date
      t.date :finished_date
      t.date :approved_date
      t.references :house, foreign_key: true
      t.references :owner_user
      t.references :assignee_user
      t.references :reviewer_user

      t.timestamps
    end
    add_foreign_key :tasks, :users, column: :owner_user_id
    add_foreign_key :tasks, :users, column: :assignee_user_id
    add_foreign_key :tasks, :users, column: :reviewer_user_id
  end
end
