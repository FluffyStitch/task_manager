# frozen_string_literal: true

RSpec.describe 'Tasks > _task', type: :feature, js: true do
  before do
    User.find_by(email: 'user@example.com').projects.create(name: 'First project').tasks.create(text: 'First task')
    visit root_path
    fill_in :user_email, with: 'user@example.com'
    fill_in :user_password,	with: 'password'
    click_button 'Log in'
  end

  it 'success edit task' do
    click_on :Edit_task
    find('#modal-window').fill_in :task_text, with: 'First edit task'
    click_on 'Edit task'
    expect(page).to have_xpath "//p[contains(text(), 'First edit task')]"
  end

  it 'failed edit task' do
    click_on :Edit_task
    find('#modal-window').fill_in :task_text, with: ''
    click_on 'Edit task'
    expect(page).to have_css '.invalid-feedback'
  end

  it 'delete' do
    click_on :Delete_task
    expect(page).to have_no_xpath "//p[contains(text(), 'First task')]"
  end
end
