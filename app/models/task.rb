# frozen_string_literal: true

class Task < ApplicationRecord
  include AASM

  belongs_to :house
  belongs_to :owner, class_name: 'User', inverse_of: :owned_tasks
  belongs_to :assignee, class_name: 'User', inverse_of: :assigned_tasks, optional: true
  belongs_to :reviewer, class_name: 'User', inverse_of: :reviewed_tasks, optional: true
  has_many :comments, dependent: :destroy
  has_many :comenting_users, { through: :comments, source: :user }

  aasm do
    state :created, initial: true
    state :assigned, :finished, :approved

    event :assign do
      transitions from: :created, to: :assigned
    end

    event :finish do
      transitions from: :assigned, to: :finished
    end

    event :unassign do
      transitions from: :assigned, to: :created
    end

    event :approve do
      transitions from: :finished, to: :approved
    end
    event :reject do
      transitions from: :finished, to: :assigned
    end
  end

  validates :name, :description, :category, :limit_date, presence: true
  # Validación de soft delete
  acts_as_paranoid
  # Enum de categorías de tareas
  enum category: { 'Limpieza' => 0, 'Cocina' => 1, 'Compras' => 2, 'Mascota' => 3 }
end
