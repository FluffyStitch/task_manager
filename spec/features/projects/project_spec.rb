# frozen_string_literal: true

RSpec.describe 'Projects > _project', type: :feature, js: true do
  before do
    # email = FFaker::Internet.email
    # user = User.create(email: email, password: 'password')
    User.find_by(email: 'user@example.com').projects.create(name: 'First project')
    visit root_path
    fill_in :user_email, with: 'user@example.com'
    fill_in :user_password,	with: 'password'
    click_button 'Log in'
  end

  it 'success edit project' do
    click_on :Edit_project
    fill_in :project_name,	with: 'First edit project'
    click_on 'Edit project'
    expect(page).to have_xpath "//div[contains(text(), 'First edit project')]"
  end

  it 'failed edit project' do
    click_on :Edit_project
    fill_in :project_name,	with: ''
    click_on 'Edit project'
    expect(page).to have_css '.invalid-feedback'
  end

  it 'delete' do
    click_on :Delete_project
    expect(page).to have_no_xpath "//div[contains(text(), 'First project')]"
  end

  it 'click plus button' do
    find('.visibility_button').click
    expect(page).to have_css '#task_deadline'
  end
end
