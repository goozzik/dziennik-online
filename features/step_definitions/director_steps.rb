# coding: utf-8

Then /^I should see director navigation$/ do
  assert page.has_xpath?("//a[@href='/'][contains(text(), \"Strona główna\")]")
  assert page.has_xpath?("//a[@href='/director/school_classes'][contains(text(), \"Klasy\")]")
  assert page.has_xpath?("//a[@href='/users/edit'][contains(text(), \"Ustawienia\")]")
end

Then /^I should see classes absences table$/ do
  assert page.has_xpath?("//td[contains(text(), '1 G 2011')]")
  assert page.has_xpath?("//td/a[@href='/director/absences/general/#{SchoolClass.first.id}'][contains(text(), 'Pokaż')]")
  assert page.has_xpath?("//td/a[@href='/director/absences/#{SchoolClass.first.id}'][contains(text(), 'Pokaż')]")
end

Then /^I should see general absences$/ do
  assert page.has_xpath?("//td[contains(text(), 'Jacek')]")
  assert page.has_xpath?("//td[contains(text(), 'Placek')]")
  assert page.has_xpath?("//td[contains(text(), '75.76')]")
  assert page.has_xpath?("//td[contains(text(), '54')]")
  assert page.has_xpath?("//td[contains(text(), '18')]")
  assert page.has_xpath?("//td[contains(text(), '9')]")
end

Then /^I should see semesters navigation$/ do
  assert page.has_xpath?("//a[@href='/director/absences/general/#{SchoolClass.first.id}?semester_id=#{Semester.first.id}'][contains(text(), 'Semestr 1')]")
end

Then /^I should see mark "([^"]*)" and average mark "([^"]*)"$/ do |mark, avg|
  assert page.has_xpath?("//td[contains(text(), '#{mark}')]")
  assert page.has_xpath?("//td[contains(text(), '#{avg}')]")
end

Given /^created semester is loaded$/ do
  find_model("semester: \"Semestr 1\"")
end