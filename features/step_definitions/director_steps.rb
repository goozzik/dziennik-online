# coding: utf-8

Then /^I should see director navigation$/ do
  assert page.has_xpath?("//a[@href='/'][contains(text(), \"Strona główna\")]")
  assert page.has_xpath?("//a[@href='/director/absences'][contains(text(), \"Frekwencja\")]")
  assert page.has_xpath?("//a[@href='/director/subjects'][contains(text(), \"Oceny\")]")
  assert page.has_xpath?("//a[@href='/users/edit'][contains(text(), \"Ustawienia\")]")
end
