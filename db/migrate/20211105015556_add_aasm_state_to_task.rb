# frozen_string_literal: true

class AddAasmStateToTask < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :aasm_state, :string
  end
end
