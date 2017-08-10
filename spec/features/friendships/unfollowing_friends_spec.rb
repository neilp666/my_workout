require "rails_helper"

RSpec.feature "Unfollowing friend" do
  before do
    @neil = User.create(first_name: "Neil",
                        last_name: "Smith",
                        email: "neil@example.com",
                        password: "password")

    @sarah = User.create(first_name: "Sarah",
                        last_name: "Smith",
                        email: "sarah@example.com",
                        password: "password")

    login_as(@neil)

    @following = Friendship.create(user: @neil, friend: @sarah)
  end

  scenario do
    visit "/"

    click_link "My Workout"
    link = "a[href='/friendships/#{@following.id}'][data-method='delete']"
    find(link).click

    expect(page).to have_content(@sarah.full_name + " unfollowed")
  end
end
