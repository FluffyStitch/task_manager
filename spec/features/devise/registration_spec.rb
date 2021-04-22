# frozen_string_literal: true

RSpec.describe 'Registration', type: :feature, js: true do
  let(:current_page) { Registration.new }

  before do
    current_page.load
  end

  describe 'registration a new user' do
    let(:email) { FFaker::Internet.email }
    let(:password) { FFaker::Internet.password }
    let(:password_confirmation) { password }

    before do
      current_page.form.email.fill_in(with: email)
      current_page.form.password.fill_in(with: password)
      current_page.form.password_confirmation.fill_in(with: password_confirmation)
      current_page.form.sign_up.click
    end

    context 'when params is valid' do
      it 'success' do
        expect(current_page).to have_content I18n.t('devise.registrations.signed_up')
      end
    end

    context 'when password confirmation is not correct' do
      let(:password_confirmation) { FFaker::Internet.password }

      it 'failed registation a new user' do
        expect(current_page).to have_content I18n.t('simple_form.error_notification.default_message')
      end
    end
  end

  it 'redirect to log in page' do
    current_page.log_in.click

    expect(current_page).to have_content I18n.t('log_in.remember_me')
  end
end
