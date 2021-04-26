# frozen_string_literal: true

ActiveAdmin.register Task do
  permit_params :task, :project_id, :deadline
end
