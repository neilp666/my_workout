require "rails_helper"

RSpec.feature "Listing Exercises" do
  before do
   @neil = User.create(email: "neil@example.com", password: "password")
   login_as(@neil)

   @e1 = @neil.exercises.create(duration_in_min: 20,
                                workout: "My body building activity",
                                workout_date: Date.today)
   @e2 = @neil.exercises.create(duration_in_min: 55,
                                workout: "Weight lifting",
                                workout_date: 2.days.ago)
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
end
