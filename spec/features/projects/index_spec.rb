# frozen_string_literal: true

RSpec.describe 'Projects > Index', type: :feature, js: true do
  let(:current_page) { Index.new }
  let!(:user) { create(:user) }

  before do
    sign_in user
    current_page.load
  end

  it 'exit' do
    current_page.sign_out.click

    expect(current_page).to have_content 'You need to sign in or sign up before continuing.'
  end

  it 'modal-window to add TODO list' do
    current_page.add_project.click

    expect(current_page).to have_css '#modal-window'
  end

  it 'success add TODO list' do
    current_page.add_project.click
    current_page.new_project.project_name.fill_in(with: 'First project')
    current_page.new_project.add_new_project.click

    expect(current_page).to have_xpath "//div[contains(text(), 'First project')]"
  end

  it 'failed add TODO list' do
    current_page.add_project.click
    current_page.new_project.project_name.fill_in(with: '')
    current_page.new_project.add_new_project.click

    expect(current_page).to have_css '.invalid-feedback'
  end
end
