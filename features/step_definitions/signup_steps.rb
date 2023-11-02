
# features/step_definitions/signup_steps.rb

Given("I am on the log-in page") do
  visit new_user_session_path
end

Given("I have a registered user with the following credentials:") do |table|
  user_data = table.hashes.first
  User.create({
    :email => user_data["Email"],
    :password => user_data["Password"],
    :password_confirmation => user_data["Password"]
  })
end

Given("I am on the sign-up page") do
    visit new_user_registration_path # Assuming you're using Devise for user management
  end
  
  When(/^I fill in the (sign-up|log-in) form correctly$/) do |page_type|
    case page_type
    when "sign-up"
      fill_in "Email", with: "test@example.com"
      fill_in "Password", with: "password123"
      fill_in "Password confirmation", with: "password123"
    when "log-in"
      fill_in "Email", with: "user@example.com"
      fill_in "Password", with: "password123"
    end
  end
  
  When(/^I fill in the (sign-up|log-in) form incorrectly$/) do |page_type|
    case page_type
    when "sign-up"
      fill_in "Email", with: "test@example.com"
      fill_in "Password", with: "password123"
      fill_in "Password confirmation", with: "wrongpassword"
    when "log-in"
      fill_in "Email", with: "user@example.com"
      fill_in "Password", with: "wrongpassword"
    end
  end
  
  When("I click the {string} button") do |button|
    click_on(button)
  end

  
  Then("I should see {string}") do |message|
    expect(page).to have_content(message)
  end
  
