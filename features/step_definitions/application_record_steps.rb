Given("I have an ApplicationRecord") do
    # No need to create an instance; it's an abstract class
  end
  
  When("I check if it is an abstract class") do
    @is_abstract_class = ApplicationRecord.abstract_class?
  end
  
  Then("it should be an abstract class") do
    expect(@is_abstract_class).to be_truthy
  end