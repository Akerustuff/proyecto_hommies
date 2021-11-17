# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :task

  paginates_per 2
  # Validación de soft delete
  acts_as_paranoid
end
