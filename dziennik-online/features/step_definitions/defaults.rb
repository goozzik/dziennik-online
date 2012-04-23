Then /^I should see "([^"]*)"$/ do |text|
  assert page.has_content?(text)
end
