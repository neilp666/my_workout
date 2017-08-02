require 'rails_helper'

RSpec.feature "Users signin link" do
  before do
    @neil = User.create(email: "neil@example.com", password: "password")
  end

scenario "upon successful signin" do
  visit "/"

  click_link "Sign in"
  fill_in "Email", with: @neil.email
  fill_in "Password", with: @neil.password
  click_button "Log in"

  expect(page).to have_link("Sign out")
  expect(page).not_to have_link("Sign in")
  expect(page).not_to have_link("Sign up")
 end
end
