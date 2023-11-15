require 'rails_helper'

RSpec.feature 'User Authentication', type: :feature do
  scenario 'User signs up and logs in' do
    visit new_registration_path
    fill_in 'Username', with: 'MaryAnn'
    fill_in 'Email', with: 'maryann@gmail.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button 'Sign up'

    expect(page).to have_content('Signup successful!')

    click_link 'Logout'
    expect(page).to have_content('Logged out!')

    visit login_path
    fill_in 'Username', with: 'MaryAnn'
    fill_in 'Password', with: 'password'
    click_button 'Login'

    expect(page).to have_content('Logged in successfully.')
  end
end