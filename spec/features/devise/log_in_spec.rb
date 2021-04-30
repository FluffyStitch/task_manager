# frozen_string_literal: true

RSpec.describe 'Log in', type: :feature, js: true do
  let(:current_page) { SignIn.new }
  let!(:user) { create(:user) }

  before do
    current_page.load
  end

  describe 'log in' do
    before do
      current_page.form.email.fill_in(with: user.email)
      current_page.form.password.fill_in(with: password)
      current_page.form.remember_me.check
      current_page.form.sign_in.click
    end

    context 'when params is valid' do
      let(:password) { user.password }

      it 'success' do
        expect(current_page).to have_content I18n.t('devise.sessions.signed_in')
      end
    end

    context 'when password is not correct' do
      let(:password) { FFaker::Internet.email }

      it 'failed' do
        expect(current_page).to have_content I18n.t('devise.failure.invalid', authentication_keys: 'Email')
      end
    end
  end

  it 'redirect to sign up page' do
    current_page.sign_up.click

    expect(current_page).to have_content I18n.t('sign_up.password.confirmation')
  end
end
