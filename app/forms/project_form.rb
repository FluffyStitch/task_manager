# frozen_string_literal: true

class ProjectForm < Reform::Form
  include Reform::Form::ActiveRecord
  property :name

  validates :name, presence: true
  validates_uniqueness_of :name
end
