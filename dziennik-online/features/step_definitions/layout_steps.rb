# coding: utf-8
When /^(?:|I )go to (.+)$/ do |page_name|
  case page_name
  when 'the home page'
    visit('/')
  when 'the teacher school classes index page'
    visit('/teacher/school_classes')
  end
end

Then /^I should see login box$/ do
  assert page.has_xpath?("//form[@action='/users/sign_in']")
  assert page.has_xpath?("//input[@name='user[username]']")
  assert page.has_xpath?("//input[@name='user[password]']")
end
