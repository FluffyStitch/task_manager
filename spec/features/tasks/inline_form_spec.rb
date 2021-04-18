# frozen_string_literal: true

RSpec.describe 'Tasks > _inline_form', type: :feature, js: true do
  before do
    User.find_by(email: 'user@example.com').projects.create(name: 'First project')
    visit root_path
    fill_in :user_email, with: 'user@example.com'
    fill_in :user_password,	with: 'password'
    click_button 'Log in'
  end

  describe 'without deadline' do
    it 'success add task' do
      fill_in :task_text,	with: 'First task'
      click_on 'Add task'
      expect(page).to have_xpath "//p[contains(text(), 'First task')]"
    end

    it 'failed add task' do
      fill_in :task_text,	with: ''
      click_on 'Add task'
      expect(page).to have_css '.invalid-feedback'
    end
  end

  describe 'with deadline' do
    before do
      find('.visibility_button').click
    end

    it 'success add task' do
      fill_in :task_text,	with: 'First task'
      # find('#task_deadline').click
      fill_in :task_deadline,	with: '2024-04-14'
      click_on 'Add task'
      expect(page).to have_xpath "//p[contains(text(), '2024-04-14')]"
    end

    it 'failed add task' do
      fill_in :task_text,	with: ''
      fill_in :task_deadline,	with: '2024-04-14'
      click_on 'Add task'
      expect(page).to have_field(:task_deadline, with: '2024-04-14')
    end
  end
end
