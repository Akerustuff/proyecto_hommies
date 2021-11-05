# frozen_string_literal: true

class Task < ApplicationRecord
  include AASM

  belongs_to :house
  belongs_to :owner, class_name: 'User', inverse_of: :owned_tasks
  belongs_to :assignee, class_name: 'User', inverse_of: :assigned_tasks
  belongs_to :reviewer, class_name: 'User', inverse_of: :reviewed_tasks, optional: true

  aasm do
    state :created, initial: true
    state :finished, :approved

    event :finish do
      transitions from: :created, to: :finished
    end

    event :approve do
      transitions from: :finished, to: :approved
    end
  end

  validates :name, :description, :category, :limit_date, presence: true

  enum category: { 'Limpieza' => 0, 'Cocina' => 1, 'Compras' => 2 }
end
