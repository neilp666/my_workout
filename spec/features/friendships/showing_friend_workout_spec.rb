require "rails_helper"

RSpec.feature "Showing friend Workout" do
  before do
    @neil = User.create(first_name: "Neil",
                        last_name: "Smith",
                        email: "neil@example.com",
                        password: "password")

    login_as(@neil)

    @sarah = User.create(first_name: "Sarah",
                        last_name: "Smith",
                        email: "sarah@example.com",
                        password: "password")

    @e1 = @neil.exercises.create(duration_in_min: 74,
                                workout: "My body building activity",
                                workout_date: Date.today)
    @e2 = @sarah.exercises.create(duration_in_min: 55,
                                workout: "Weight lifting",
                                workout_date: Date.today)

    login_as(@neil)

    @following = Friendship.create(user: @neil, friend: @sarah)
end

scenario "shows friend's workout for last 7 days" do
  visit "/"

  click_link "My Workout"
  click_link @neil.full_name

  expect(page).to have_content(@neil.full_name + "'s Exercises")
  expect(page).to have_content(@e2.workout)
  expect(page).to have_css("div#chart")
 end
end
