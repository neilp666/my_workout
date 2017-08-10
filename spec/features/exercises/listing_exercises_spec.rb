require "rails_helper"

RSpec.feature "Listing Exercises" do
  before do
   @neil = User.create(first_name: "Neil", last_name: "smith", email: "neil@example.com", password: "password")
   login_as(@neil)
   @sarah = User.create(first_name: "Sarah", last_name: "Anderson", email: "sarah@example.com", password: "password")
   login_as(@neil)

   @e1 = @neil.exercises.create(duration_in_min: 20,
                                workout: "My body building activity",
                                workout_date: Date.today)
   @e2 = @neil.exercises.create(duration_in_min: 55,
                                workout: "Weight lifting",
                                workout_date: 2.days.ago)
   @following = Friendship.create(user: @neil, friend: @sarah)
end

scenario "shows user's workout for the last 7 days" do
  visit "/"

  click_link "My Workout"

  expect(page).to have_content(@e1.duration_in_min)
  expect(page).to have_content(@e1.workout)
  expect(page).to have_content(@e1.workout_date)

  expect(page).to have_content(@e2.duration_in_min)
  expect(page).to have_content(@e2.workout)
  expect(page).to have_content(@e2.workout_date)

 end

  scenario "shows no exercises if none created" do
    @neil.exercises.delete_all
    visit '/'
    click_link "My Workout"
    expect(page).to have_content("No Workouts Yet")
end

  scenario "shows a list of user's friends" do
    visit "/"

    click_link "My Workout"
    expect(page).to have_content("My Friends")
    expect(page).to have_link(@sarah.full_name)
    expect(page).to have_link("Unfollow")
  end
end
