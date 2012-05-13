# coding: utf-8
Then /^I should see student navigation$/ do
  assert page.has_xpath?("//a[@href='/'][contains(text(), \"Strona główna\")]")
  assert page.has_xpath?("//a[@href='/student/marks'][contains(text(), \"Oceny\")]")
  assert page.has_xpath?("//a[@href='/student/absences'][contains(text(), \"Frekwencja\")]")
  assert page.has_xpath?("//a[@href='/student/time_tables'][contains(text(), \"Plan lekcji\")]")
  assert page.has_xpath?("//a[@href='/users/sign_out'][contains(text(), \"Wyloguj\")]")
end

Given /^another subject exists with school_class: the school class, name: Biologia$/ do
  pending # express the regexp above with the code you wish you had
end

When /^I am going to the student marks index page$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^I should see my subjects$/ do
  subject1 = Subject.first
  subject2 = Subject.last
  assert page.has_xpath?("//a[@href='/student/subjects/#{subject1.id}']")
  assert page.has_xpath?("//a[@href='/student/subjects/#{subject2.id}']")
end
