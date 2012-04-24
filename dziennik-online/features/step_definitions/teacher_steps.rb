#coding: utf-8
Then /^I should see teacher navigation$/ do
  assert page.has_xpath?("//div[@id='navigation']")
end

Then /^I should see new class form$/ do
  assert page.has_content?("Dodaj nową klasę")
  assert page.has_xpath?("//form[@action='/teacher/school_classes']")
  assert page.has_xpath?("//input[@value='Stwórz']")
end

When /^I create class$/ do
  visit('/teacher/school_classes')
  fill_in('Klasa', :with => '3')
  fill_in('Nazwa', :with => 'G')
  fill_in('Profil', :with => 'Informatyk')
  fill_in('Rocznik', :with => '2013')
  click_button('Stwórz')
end

Then /^I should have class and updated teacher class_id$/ do
  school_class = SchoolClass.first(:conditions => ['year = ? AND name = ? AND profile = ? AND yearbook = ?', 3, 'G', 'Informatyk', '2013'])
  assert school_class
  assert Teacher.first.school_class == school_class
  assert school_class.active
end

Then /^I should have semester and updated teacher semester_id$/ do
  school_class = SchoolClass.first(:conditions => ['year = ? AND name = ? AND profile = ? AND yearbook = ?', 3, 'G', 'Informatyk', '2013'])
  semester = Semester.first(:conditions => ['school_class_id = ?', school_class.id])
  assert semester
  assert Teacher.first.semester == semester
  assert semester.active
end

When /^click buttton add new semestr$/ do
  click_button('Dodaj nowy semestr')
end

Then /^old semester should be unactive and new one should be active$/ do
  assert !Semester.first.active
  assert Semester.last.active
end

When /^follow link to delete class$/ do
  click_link('Usuń')
end

Then /^class and semester should be deleted$/ do
  assert SchoolClass.count == 0
  assert Semester.count == 0
end
