require "rails_helper"

RSpec.feature "Deleting Exercise" do
  before do
    @owner = User.create(first_name: "Neil" , last_name: "smith", email: "owner@exmaple.com", password: "password")

    @owner_exercise = @owner.exercises.create!(duration_in_min: 48,
                                                workout: "My body building activity",
                                                workout_date: Date.today)

    login_as(@owner)
  end

  scenario "deleting exercise" do
    visit "/"

    click_link "My Workout"
    path = "/users/#{@owner.id}/exercises/#{@owner_exercise.id}"
    link = "//a[contains(@href,\'#{path}\') and .//text()='Destroy']"

    find(:xpath, link).click

    expect(page).to have_content("Exercise has been deleted")
  end

end
