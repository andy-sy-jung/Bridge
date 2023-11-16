
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

  Then("I should see a table row with the following fields:") do |table|
    table.raw.each do |field|
      field_name = field[0]
      expect(page).to have_selector('tr', text: field_name)
    end
  end

  When("I fill in the create form") do
    select 'User', from: 'posting_type_of'
    fill_in 'posting[name]', with: 'TestMan'
    select 'CS', from: 'posting_subject'
    fill_in 'posting[description]', with: 'Experienced tutor'
    fill_in 'posting[price]', with: '1000'
    fill_in 'posting[availability]', with: 'Anytime'
    fill_in 'posting[contact]', with: '0109919241'
end
  
Then("I should see the following details for the posting:") do |table|
  # Access the page content and convert it to a string
  page_content = page.body

  # Extract the details from the page content
  details = page_content.scan(/(\w+):\s+([^\n]+)/)
  details.reject! { |key, value| key == "top"}

  # Convert the table in the step to a hash of expected details
  expected_details = Hash[table.rows_hash.map { |k, v| [k, v] }]

  # Compare the expected details to the actual details
  expect(details.to_h).to eq(expected_details)
end

Then("I have the following posting by another user:") do |table|
  user = User.create({
    :email => "anotherUser@example.com",
    :password => "123456",
    :password_confirmation => "123456"
  })
  table.hashes.each do |row|
    # Merge the user_id into the row parameters
    posting_params = row.merge(user_id: user.id)

    # Create the posting
    Posting.create!(posting_params)
  end
end

Then("I should not see the {string} link") do |link_text|
  expect(page).not_to have_link(link_text)
end

Then("I should see the {string} link") do |link_text|
  expect(page).to have_link(link_text)
end

Then("I should not see a table row with the following fields:") do |table|
  values_to_exclude = table.hashes.map(&:values)

  # Assuming you have a table with the structure similar to the displayed table
  actual_rows = page.all('table#postings tbody tr').map do |row|
    row.all('td').map(&:text)
  end

  values_to_exclude.each do |expected_row|
    expect(actual_rows).not_to include(expected_row)
  end
end
