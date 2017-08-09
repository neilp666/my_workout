require "rails_helper"

RSpec.feature "Following Friends" do
  before do
    @neil = User.create(first_name: "Neil",
                        last_name: "Patel",
                        email: "neil@example.com",
                        password: "password")

    @sam = User.create(first_name: "Sam",
                        last_name: "Smith",
                        email: "sam@example.com",
                        password: "password")

    login_as(@neil)
end

  scenario "if signed in" do
    visit "/"

    expect(page).to have_content(@neil.full_name)
    expect(page).to have_content(@sam.full_name)

    href = "/friendships?friend_id=#{@neil.id}"
    expect(page).not_to have_link("Follow", :href => href)

    link = "a[href='/friendships?friend_id=#{@sam.id}']"
    find(link).click

    href = "/friendships?friend_id=#{@sam.id}"
    expect(page).not_to have_link("Follow", :href => href)
  end
end
