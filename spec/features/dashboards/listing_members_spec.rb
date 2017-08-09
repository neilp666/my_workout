require "rails_helper";

RSpec.feature "Listing Members" do
  before do
    @neil = User.create(first_name: "Neil",
                        last_name: "Smith",
                        email: "neil@example.com",
                        password: "password")

    @sarah = User.create(first_name: "Sarah",
                        last_name: "Smith",
                        email: "sarah@example.com",
                        password: "password")
  end

  scenario "shows a list of registered members" do
    visit "/"

    expect(page).to have_content("List of Members")
    expect(page).to have_content(@neil.full_name)
    expect(page).to have_content(@sarah.full_name)
  end
end
