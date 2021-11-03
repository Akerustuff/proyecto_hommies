# frozen_string_literal: true

class Task < ApplicationRecord
  belongs_to :house
  belongs_to :owner, class_name: 'User'
  belongs_to :assignee, class_name: 'User'
  belongs_to :reviewer, class_name: 'User', optional: true

  validates :name, :description, :category, :limit_date, presence: true

  enum category: { 'categoria 1' => 0, 'categoria 2' => 1, 'categoria 3' => 2 }
end
