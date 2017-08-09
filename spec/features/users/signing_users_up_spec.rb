require "rails_helper"

RSpec.feature "Users Signup" do
  scenario "with valid credentials" do
    visit "/"

    click_link "Sign up"
    fill_in "First name", with: "Neil"
    fill_in "Last name", with: "Smith"
    fill_in "Email", with: "neil@example.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_button "Sign up"

    expect(page).to have_content("You have signed up successfully.")
    visit "/"

    expect(page).to have_content("Neil Smith")
  end

  scenario "with invalid credentials" do
    visit "/"

    click_link "Sign up"
    fill_in "First name", with: ""
    fill_in "Last name", with: ""
    fill_in "Email", with: "neil@example.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_button "Sign up"

    expect(page).to have_content("First name can't be blank")
    expect(page).to have_content("Last name can't be blank")
 end
end
