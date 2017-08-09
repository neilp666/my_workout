require "rails_helper"

RSpec.feature "Creating Exercise" do
  before do
    @neil = User.create(first_name: "Neil", last_name: "Smith", email: "neil@example.com", password: "password")
    login_as(@neil)

    visit "/"

    click_link "My Workout"
    click_link "New Workout"
    expect(page).to have_link("Back")
  end

  scenario "with valid inputs" do

    fill_in "Duration", with: 70
    fill_in "Workout details", with: "Weight lifting"
    fill_in "Activity date", with: "01-08-2017"
    click_button "Create Exercise"

    expect(page).to have_content("Exercise has been created")

    exercise = Exercise.last
    expect(current_path).to eq(user_exercise_path(@neil, exercise))
    expect(exercise.user_id).to eq(@neil.id)
  end

  scenario "with invalid inputs" do
   
    fill_in "Duration", with: ""
    fill_in "Workout details", with: ""
    fill_in "Activity date", with:  ""
    click_button "Create Exercise"

    expect(page).to have_content("Exercise has not been created")
    expect(page).to have_content("Duration in min is not a number")
    expect(page).to have_content("Workout details can't be blank")
    expect(page).to have_content("Activity date can't be blank")
  end
end
