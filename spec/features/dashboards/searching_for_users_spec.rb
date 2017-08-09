require "rails_helper"

RSpec.feature "Searching for User" do
  before do
    @neil = User.create!(first_name: "Neil",
                        last_name: "Smith",
                        email: "neil@example.com",
                        password: "password")

    @sarah = User.create!(first_name: "Sarah",
                          last_name: "Smith",
                          email: "sarah@example.com",
                          password: "password")
end

scenario "with existing name returns all those users" do
  visit '/'

  fill_in "search_name", with: "Smith"
  click_button "Search"

  expect(page).to have_content(@neil.full_name)
  expect(page).to have_content(@sarah.full_name)
  expect(current_path).to eq("/dashboards/search")
 end

end
