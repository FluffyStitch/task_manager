# frozen_string_literal: true

class TaskModal < SitePrism::Section
  element :task_text, '#task_text'
  element :submit, '[type="submit"]'
  element :error, '.invalid-feedback'
end
