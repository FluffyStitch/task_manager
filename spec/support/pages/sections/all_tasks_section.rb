# frozen_string_literal: true

class AllTasks < SitePrism::Section
  element :completed, '#task_completed'
  element :text, '.text-left'
  element :deadline, '.deadline'
  element :up, '.bi-chevron-up'
  element :down, '.bi-chevron-down'
  element :edit, '.bi-pencil'
  element :delete, '.bi-trash'
end
