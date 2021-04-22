# frozen_string_literal: true

Dir[Rails.root.join('spec/support/pages/sections/*')].sort.each { |file| require file }

class ProjectIndex < SitePrism::Page
  set_url '/'

  element :sign_out, '[href="/users/sign_out"]'

  sections :projects, Projects, 'table[id^=project_]'

  section :project_modal, ProjectModal, '#modal-window'

  section :task_modal, TaskModal, '#modal-window'

  element :add_project, '[href="/projects/new"]'

  section :flatpickr, Flatpickr, '.flatpickr-calendar'

  def first_project
    projects.first
  end

  def first_task
    first_project.tasks.first
  end

  def second_task
    first_project.tasks[2]
  end
end
