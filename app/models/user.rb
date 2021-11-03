# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :house, optional: true
  has_many :owned_tasks, class_name: 'Task', foreign_key: 'owner_id', dependent: nil, inverse_of: :task
  has_many :assigned_tasks, class_name: 'Task', foreign_key: 'assignee_id', dependent: nil, inverse_of: :task
  has_many :reviewed_tasks, class_name: 'Task', foreign_key: 'reviewer_id', dependent: nil, inverse_of: :task

  validates :first_name, :last_name, presence: true

  def to_s
    first_name
  end
end
