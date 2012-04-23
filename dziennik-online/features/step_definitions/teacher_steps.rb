Then /^I should see teacher navigation$/ do
  assert page.has_xpath?("//div[@id='navigation']")
end
