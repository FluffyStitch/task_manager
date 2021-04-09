# frozen_string_literal: true

class ProjectForm < Reform::Form
  property :name

  validates :name, presence: true
end
