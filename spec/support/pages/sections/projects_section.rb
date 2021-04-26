# frozen_string_literal: true

class Projects < SitePrism::Section
  element :name, '#name'
  element :edit, '.bi-pencil'
  element :delete, '.bi-trash'

  element :plus, '.visibility_button'
  section :new_task, NewTask, '#new_task'

  sections :tasks, AllTasks, 'tbody tr[id^=task_]'
end
