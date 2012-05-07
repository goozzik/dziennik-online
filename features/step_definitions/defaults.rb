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
  when 'the teacher subject page'
    visit('/teacher/subjects/' + Subject.last.id.to_s)
  when 'the teacher students index page'
    visit('/teacher/students')
  when 'the teacher absences may index page'
    visit('/teacher/absences?date=2012-05-07')
  when 'the teacher time tables index page'
    visit('/teacher/time_tables')
  when 'the teacher documents index page'
    visit('/teacher/documents')
  else
    raise "No route given: " + page_name
  end
end

Then /^show me the page$/ do
  save_and_open_page
end
