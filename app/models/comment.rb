# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :task
  has_many_attached :images

  paginates_per 10
  # Validación de soft delete
  acts_as_paranoid

  def comment_image_style(input)
    images[input].variant(resize: '300x300').processed
  end
end
