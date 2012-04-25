
Then /^I should see login box$/ do
  assert page.has_xpath?("//form[@action='/users/sign_in']")
  assert page.has_xpath?("//input[@name='user[username]']")
  assert page.has_xpath?("//input[@name='user[password]']")
end
