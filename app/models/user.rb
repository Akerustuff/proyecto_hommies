# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :house, optional: true
  has_many :owned_tasks, class_name: 'Task', foreign_key: 'owner_id', dependent: nil, inverse_of: :owner
  has_many :assigned_tasks, class_name: 'Task', foreign_key: 'assignee_id', dependent: nil, inverse_of: :assignee
  has_many :reviewed_tasks, class_name: 'Task', foreign_key: 'reviewer_id', dependent: nil, inverse_of: :reviewer

  validates :first_name, :last_name, presence: true

  def to_s
    first_name
  end

  def user_pending_tasks
    assigned_tasks.assigned
  end

  def change_ownership_tasks
    tasks = Task.where(owner_id: id)
    owner_house = User.find_by(owner: true, house_id: house_id)
    tasks.each do |task|
      task.owner_id = owner_house.id
      task.save
    end
  end

  def unassign_tasks
    tasks = Task.where(assignee_id: id)
    tasks.each do |task|
      task.assignee_id = nil
      task.save
    end
  end
end
