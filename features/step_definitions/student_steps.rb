# coding: utf-8
Then /^I should see student navigation$/ do
  assert page.has_xpath?("//a[@href='/'][contains(text(), \"Strona główna\")]")
  assert page.has_xpath?("//a[@href='/student/marks'][contains(text(), \"Oceny\")]")
  assert page.has_xpath?("//a[@href='/student/absences'][contains(text(), \"Frekwencja\")]")
  assert page.has_xpath?("//a[@href='/student/time_tables'][contains(text(), \"Plan lekcji\")]")
  assert page.has_xpath?("//a[@href='/users/sign_out'][contains(text(), \"Wyloguj\")]")
end

Then /^I should see my marks$/ do
  assert page.has_xpath?("//td[contains(text(), \"4\")]")
  assert page.has_xpath?("//td[contains(text(), \"1\")]")
end

Then /^I should see my absences$/ do
  assert page.has_content?("2012-05-07")
  assert page.has_content?("Maj")
  assert page.has_xpath?("//td[contains(text(), \"33\")]")
  assert page.has_xpath?("//td[contains(text(), \"6\")]")
  assert page.has_xpath?("//td[contains(text(), \"2\")]")
end

Then /^I should see information that i don't have any absences$/ do
  assert page.has_content?("Wychowawca nie uzupełnił jeszcze frekwencji.")
end

Then /^I should see my time tables$/ do
  assert page.has_content?("Poniedziałek")
  assert page.has_content?("Wtorek")
  assert page.has_xpath?("//td[contains(text(), '0')]")
  assert page.has_xpath?("//td[contains(text(), '1')]")
  assert page.has_xpath?("//td[contains(text(), 'Biologia')]")
end

Then /^I should see information that there is no time tables now$/ do
  assert page.has_content?("Wychowawca nie uzupełnił jeszcze planu lekcji.")
end
