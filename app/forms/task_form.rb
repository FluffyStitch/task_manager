# frozen_string_literal: true

class TaskForm < Reform::Form
  include Reform::Form::ActiveRecord
  property :text
  property :deadline
  property :project_id

  validates :text, presence: true
  validate :valid_deadline

  private

  def valid_deadline
    return unless deadline.present? && Time.zone.parse(deadline).nil?

    errors.add(:deadline, I18n.t('project.errors.deadline.invalid_format'))
  end
end
