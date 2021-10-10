# frozen_string_literal: true

class House < ApplicationRecord
  has_many :users, dependent: :nil

  before_create :generate_code

  def generate_code
    self.code = Array.new(8) { [*'A'..'Z', *'0'..'9'].sample }.join
  end
end
