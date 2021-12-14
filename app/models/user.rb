# frozen_string_literal: true

require 'open-uri'

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :validatable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :omniauthable, omniauth_providers: [:google_oauth2]

  has_one_attached :avatar
  belongs_to :house, optional: true
  has_many :comments, dependent: :destroy
  has_many :commented_tasks, { through: :comments, source: :task }
  has_many :owned_tasks, class_name: 'Task', foreign_key: 'owner_id',
                         dependent: nil, inverse_of: :owner
  has_many :assigned_tasks, class_name: 'Task', foreign_key: 'assignee_id',
                            dependent: nil, inverse_of: :assignee
  has_many :reviewed_tasks, class_name: 'Task', foreign_key: 'reviewer_id',
                            dependent: nil, inverse_of: :reviewer

  validates :first_name, :last_name, presence: true
  # Validación de soft delete
  acts_as_paranoid

  before_create do
    file_path = 'app/assets/images/default_avatar.png'
    file_name = 'default_avatar.png'
    avatar.attach(io: File.open(file_path), filename: file_name) unless avatar.attached?
  end

  def to_s
    first_name
  end

  def my_tasks
    Task.where(owner_id: id).or(Task.where(assignee_id: id)).or(Task.where(reviewer_id: id))
  end

  def user_pending_tasks
    assigned_tasks.assigned
  end

  def user_per_assign_tasks
    Task.where(owner_id: id, assignee_id: nil)
  end

  def user_per_approve_tasks
    Task.where(house_id: house_id, aasm_state: 'finished').where.not(assignee_id: id)
  end

  def user_approved_tasks
    Task.where(reviewer_id: id)
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

  def avatar_photo
    avatar.variant(resize: '100x100')
  end

  def profile_photo
    avatar.variant(resize: '300x300')
  end

  def edit_avatar_photo
    avatar.variant(resize: '250x250')
  end

  def thumbnail_photo
    avatar.variant(resize: '50x50')
  end
end
