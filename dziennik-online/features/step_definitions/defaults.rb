Then /^I should see "([^"]*)"$/ do |text|
  assert page.has_content?(text)
end

# coding: utf-8
When /^(?:|I )go to (.+)$/ do |page_name|
  case page_name
  when 'the home page'
    visit('/')
  when 'the teacher school classes index page'
    visit('/teacher/school_classes')
  when 'the teacher subjects index page'
    visit('/teacher/subjects')
  end
end
