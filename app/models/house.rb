# frozen_string_literal: true

class House < ApplicationRecord
  before_create :generate_code

  has_many :users, dependent: nil
  has_many :tasks, dependent: :destroy
  validates :name, presence: true

  def house_pending_tasks(current_user)
    house = House.find_by(id: current_user.house_id)
    house.tasks.where(aasm_state: %w[created assigned])
  end

  private

  def generate_code
    self.code = Array.new(8) { [*'A'..'Z', *'0'..'9'].sample }.join
  end
end
