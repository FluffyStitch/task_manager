# frozen_string_literal: true

RSpec.describe 'Log in', type: :feature, js: true do
  let(:current_page) { SignIn.new }
  let!(:user) { create(:user) }

  before do
    current_page.load
  end

  it 'success' do
    current_page.form.email.fill_in(with: user.email)
    current_page.form.password.fill_in(with: user.password)
    current_page.form.remember_me.check
    current_page.form.sign_in.click

    expect(current_page).to have_content 'Signed in successfully.'
  end

  it 'failed' do
    current_page.form.email.fill_in(with: user.email)
    current_page.form.password.fill_in(with: 'sometext')
    current_page.form.sign_in.click

    expect(current_page).to have_content 'Invalid Email or password.'
  end

  it 'redirect to sign up page' do
    current_page.sign_up.click

    expect(current_page).to have_content 'Password confirmation'
  end
end
