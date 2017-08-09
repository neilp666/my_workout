require "rails_helper"
RSpec.feature "Signing users out" do
  before do
    @neil = User.create!(first_name: "Neil" , last_name: "smith", email: "neil@example.com",
                         password: "password")
    visit '/'
    click_link "Sign in"
    fill_in "Email", with: @neil.email
    fill_in "Password", with: @neil.password
    click_button "Log in"
  end
  scenario do
    visit "/"
    click_link "Sign out"
    expect(page).to have_content("Signed out successfully")
  end
end
