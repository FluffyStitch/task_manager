# frozen_string_literal: true

ActiveAdmin.register Project do
  permit_params :name
end
