# coding: utf-8

Then /^I should see director navigation$/ do
  assert page.has_xpath?("//a[@href='/'][contains(text(), \"Strona główna\")]")
  assert page.has_xpath?("//a[@href='/director/absences'][contains(text(), \"Frekwencja\")]")
  assert page.has_xpath?("//a[@href='/director/subjects'][contains(text(), \"Oceny\")]")
  assert page.has_xpath?("//a[@href='/users/edit'][contains(text(), \"Ustawienia\")]")
end

Given /^I have example teachers with active classes$/ do
  school = FactoryGirl.create(:school)
  teacher1 = FactoryGirl.create(:teacher, :school_id => school.id)
  teacher2 = FactoryGirl.create(:teacher, :username => 'teacher2', :school_id => school.id)
  school_class1 = FactoryGirl.create(:school_class, :teacher_id => teacher1.id)
  school_class2 = FactoryGirl.create(:school_class, :teacher_id => teacher2.id)
end

Then /^I should see classes table$/ do
end
