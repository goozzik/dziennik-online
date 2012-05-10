# coding: utf-8

Then /^I should see director navigation$/ do
  assert page.has_xpath?("//a[@href='/'][contains(text(), \"Strona główna\")]")
  assert page.has_xpath?("//a[@href='/director/absences'][contains(text(), \"Frekwencja\")]")
  assert page.has_xpath?("//a[@href='/director/subjects'][contains(text(), \"Oceny\")]")
  assert page.has_xpath?("//a[@href='/users/edit'][contains(text(), \"Ustawienia\")]")
end

Then /^I should see classes absences table$/ do
  assert page.has_xpath?("//td[contains(text(), '1 G 2011')]")
  assert page.has_xpath?("//td/a[@href='/director/absences/general/#{SchoolClass.first.id}'][contains(text(), 'Pokaż')]")
  assert page.has_xpath?("//td/a[@href='/director/absences/#{SchoolClass.first.id}'][contains(text(), 'Pokaż')]")
end
