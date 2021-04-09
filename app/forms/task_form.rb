# frozen_string_literal: true

class TaskForm < Reform::Form
  property :text
  property :deadline
  property :project_id

  validates :text, presence: true
end
