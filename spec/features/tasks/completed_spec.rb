# frozen_string_literal: true

RSpec.describe 'Tasks > completed', type: :feature, js: true do
  before do
    User.find_by(email: 'user@example.com').projects.create(name: 'First project').tasks.create(text: 'First task')
    visit root_path
    fill_in :user_email, with: 'user@example.com'
    fill_in :user_password,	with: 'password'
    click_button 'Log in'
  end

  describe "don't completed" do
    it 'check' do
      check :task_completed
      expect(page).to have_checked_field :task_completed
    end
  end

  describe 'completed' do
    before do
      check :task_completed
    end

    it 'uncheck' do
      uncheck :task_completed
      expect(page).to have_no_checked_field :task_completed
    end
  end
end
