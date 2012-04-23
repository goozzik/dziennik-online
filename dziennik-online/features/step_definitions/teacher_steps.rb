#coding: utf-8
Then /^I should see teacher navigation$/ do
  assert page.has_xpath?("//div[@id='navigation']")
end

Then /^I should see new class form$/ do
  assert page.has_content?("Dodaj nową klasę")
  assert page.has_xpath?("//form[@action='/teacher/school_classes']")
  assert page.has_xpath?("//input[@value='Stwórz']")
end
