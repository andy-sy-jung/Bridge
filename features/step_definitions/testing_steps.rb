
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
    table.raw.flatten.each do |expected_detail|
      # This assumes that each detail you want to check is distinctly present in the card's text
      expect(page).to have_css('div.card', text: expected_detail)
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
  expected_details = table.rows_hash

  expected_details.each do |key, expected_value|
    # Construct the CSS selector based on the key to find the specific 'li' element
    li_element = page.find('li', text: /#{key}/)

    # Extract the text value from the 'span.text-secondary' within the found 'li' element
    actual_value = li_element.find('span.text-secondary').text.strip

    # Compare the actual value with the expected value
    expect(actual_value).to eq(expected_value)
  end
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

Then("I fill in the edit form") do
  select 'User', from: 'posting_type_of'
  fill_in 'posting[name]', with: 'TestingMan'
  select 'CS', from: 'posting_subject'
  fill_in 'posting[description]', with: 'Master Tutor'
  fill_in 'posting[price]', with: '20000'
  fill_in 'posting[availability]', with: 'Never'
  fill_in 'posting[contact]', with: '0109919241'
end

When("I uncheck all other boxes except {string}") do |preserved|
  all_subjects = Posting.all_subjects

  all_subjects.each do |subject|
    next if subject == preserved
    uncheck("subjects[#{subject}]")
  end
end