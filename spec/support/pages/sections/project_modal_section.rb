# frozen_string_literal: true

class ProjectModal < SitePrism::Section
  element :project_name, '#project_name'
  element :submit, '[type="submit"]'
  element :error, '.invalid-feedback'
end
