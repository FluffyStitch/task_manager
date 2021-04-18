# frozen_string_literal: true

RSpec.describe 'Registration', type: :feature, js: true do
  let(:current_page) { Registration.new }
  let(:email) { FFaker::Internet.email }
  let(:password) { FFaker::Internet.password }

  before do
    current_page.load
  end

  it 'success registation a new user' do
    current_page.form.email.fill_in(with: email)
    current_page.form.password.fill_in(with: password)
    current_page.form.password_confirmation.fill_in(with: password)
    current_page.form.sign_up.click

    expect(current_page).to have_content 'Welcome! You have signed up successfully.'
  end

  it 'failed registation a new user' do
    current_page.form.email.fill_in(with: email)
    current_page.form.password.fill_in(with: password)
    current_page.form.password_confirmation.fill_in(with: 'sometext')
    current_page.form.sign_up.click

    expect(current_page).to have_content 'Please review the problems below:'
  end

  it 'redirect to log in page' do
    current_page.log_in.click

    expect(current_page).to have_content 'Remember me'
  end
end
