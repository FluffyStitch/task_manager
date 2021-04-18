# frozen_string_literal: true

class Index < SitePrism::Page
  set_url '/'

  element :sign_out, '[href="/users/sign_out"]'

  section :new_project, '#modal-window' do
    element :project_name, '#project_name'
    element :add_new_project, '[type="submit"]'
  end

  element :add_project, '[href="/projects/new"]'
end
