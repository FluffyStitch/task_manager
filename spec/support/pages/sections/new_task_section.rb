# frozen_string_literal: true

class NewTask < SitePrism::Section
  element :name, '#task_text'
  element :deadline, '#task_deadline'
  element :submit, '[type="submit"]'
  element :error, '.invalid-feedback'
end
