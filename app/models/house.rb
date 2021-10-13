# frozen_string_literal: true

class House < ApplicationRecord
  before_create :generate_code

  has_many :users, dependent: nil
  # validates :name, :code, presence: true

  def generate_code
    self.code = Array.new(8) { [*'A'..'Z', *'0'..'9'].sample }.join
  end
end
