# frozen_string_literal: true

RSpec.describe 'Tasks > reprioritate', type: :feature, js: true do
  before do
    User.find_by(email: 'user@example.com').projects.create(name: 'First project').tasks.create(text: 'First task')
    User.find_by(email: 'user@example.com').projects.find_by(name: 'First project').tasks.create(text: 'Second task')
    visit root_path
    fill_in :user_email, with: 'user@example.com'
    fill_in :user_password,	with: 'password'
    click_button 'Log in'
  end

  describe 'up' do
    it 'first to first' do
      first(:css, '.bi-chevron-up').click
      expect(page).to have_xpath "//tbody/tr[1]/th[2]/div/p[contains(text(), 'First task')]"
    end

    it 'second to first' do
      find(:xpath, '//tbody/tr[2]/th[3]/div/div[1]/a[1]').click
      expect(page).to have_xpath "//tbody/tr[1]/th[2]/div/p[contains(text(), 'Second task')]"
    end
  end

  describe 'down' do
    it 'first to second' do
      find(:xpath, '//tbody/tr[1]/th[3]/div/div[1]/a[2]').click
      expect(page).to have_xpath "//tbody/tr[2]/th[2]/div/p[contains(text(), 'First task')]"
    end

    it 'last to last' do
      find(:xpath, '//tbody/tr[2]/th[3]/div/div[1]/a[2]').click
      expect(page).to have_xpath "//tbody/tr[2]/th[2]/div/p[contains(text(), 'Second task')]"
    end
  end
end
