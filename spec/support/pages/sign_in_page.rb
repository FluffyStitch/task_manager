# frozen_string_literal: true

class SignIn < SitePrism::Page
  set_url 'users/sign_in'

  section :form, '#new_user' do
    element :email, '#user_email'
    element :password, '#user_password'

    element :remember_me, '#user_remember_me'
    element :sign_in, '[type="submit"]'
  end

  element :sign_up, '[href="/users/sign_up"]'
end
