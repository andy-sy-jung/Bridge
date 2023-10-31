
# features/step_definitions/signup_steps.rb

Given("I am on the sign-up page") do
    visit new_user_registration_path # Assuming you're using Devise for user management
  end
  
  When("I fill in the sign-up form correctly") do
    fill_in "Email", with: "test@example.com"
    fill_in "Password", with: "password123"
    fill_in "Password confirmation", with: "password123"
  end
  
  When("I fill in the sign-up form incorrectly") do
    fill_in "Email", with: "test@example.com"
    fill_in "Password", with: "password123"
    fill_in "Password confirmation", with: "wrongpassword"
  end
  
  When("I click the {string} button") do |button|
    click_button button
  end
  
  Then("I should see {string}") do |message|
    expect(page).to have_content(message)
  end
  