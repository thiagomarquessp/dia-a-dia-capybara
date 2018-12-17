Given("I access the store") do
    visit '/'
    binding.pry
end
  
When("I click on my account") do
    expect(page).to have_content 'My Account'
    click_link 'My Account'
end
  
Then("I see the obrigatory fields to login") do
    expect(page).to have_content 'Username'
    expect(page).to have_content 'Password'
end