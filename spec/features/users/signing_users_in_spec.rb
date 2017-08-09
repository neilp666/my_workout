require "rails_helper"

RSpec.feature "Users signin" do
  before do
    @neil = User.create(first_name: "Neil" , last_name: "smith", email: "neil@example.com", password: "password")
  end

  scenario "with valid credentials" do
    visit "/"
    click_link "Sign in"
    fill_in "Email", with: @neil.email
    fill_in "Password", with: @neil.password
    click_button "Log in"

    expect(page).to have_content("Signed in successfully.")
    expect(page).to have_content("Signed in as #{@neil.email}")
  end
end
