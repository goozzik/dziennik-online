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

Then /^I should have active class and updated teacher class_id$/ do
  school_class = SchoolClass.first(:conditions => ['year = ? AND name = ? AND profile = ? AND yearbook = ?', 3, 'G', 'Informatyk', '2013'])
  assert school_class
  assert Teacher.first.school_class == school_class
  assert school_class.active
end

Then /^I should have active semester and updated teacher semester_id$/ do
  school_class = SchoolClass.first(:conditions => ['year = ? AND name = ? AND profile = ? AND yearbook = ?', 3, 'G', 'Informatyk', '2013'])
  semester = Semester.first(:conditions => ['school_class_id = ?', school_class.id])
  assert semester
  assert Teacher.first.semester == semester
  assert semester.active
end

When /^I create semester$/ do
  click_button('Dodaj nowy semestr')
end

Then /^first semester should be unactive and new one should be active$/ do
  assert !Semester.first.active
  assert Semester.last.active
end

When /^I delete class$/ do
  click_link('Usuń')
end

Then /^class and semester should be deleted$/ do
  assert SchoolClass.count == 0
  assert Semester.count == 0
end

When /^I delete semester$/ do
  click_button('Usuń')
end

Then /^semester should be deleted$/ do
  assert Semester.count == 0
end

Then /^I should have not set up current semester$/ do
  assert !Teacher.first.semester
end

Then /^I should have not set up current semester and school class$/ do
  assert !Teacher.first.school_class
  assert !Teacher.first.semester
end

When /^I create two classes$/ do
  step "I create class"
  fill_in('Klasa', :with => '4')
  fill_in('Nazwa', :with => 'G')
  fill_in('Profil', :with => 'Informatyk')
  fill_in('Rocznik', :with => '2012')
  click_button('Stwórz')
end

Then /^first class and semester should be deleted$/ do
  assert SchoolClass.count == 1
  assert Semester.count == 1
end

Then /^I should have set up current semester and school class$/ do
  assert Teacher.first.school_class.active
  assert Teacher.first.semester.active
end

Then /^first semester should be deleted$/ do
  assert Semester.count == 1
end

Then /^I should have set up current semester$/ do
  assert Teacher.first.semester.active
end

When /^I set first semester as active$/ do
  click_button("Ustaw")
end

Then /^first semester should be active and second not active$/ do
  assert Teacher.first.semester_id == Semester.find_by_active(true).id
  assert !Semester.last.active
  step "I should see \"Semestr 1 - aktualnie wybrany\""
end

When /^I create subject$/ do
  visit('/teacher/subjects')
  fill_in('Nazwa', :with => 'Matematyka')
  click_button('Stwórz')
end

Then /^I should have subject$/ do
  assert Teacher.first.school_class.subjects
  assert page.has_content?("Matematyka")
end

When /^I add student$/ do
  step "I go to the teacher students index page"
  fill_in('Imię', :with => 'Janusz')
  fill_in('Nazwisko', :with => 'Poncek')
  click_button("Dodaj")
end

Then /^I should have student$/ do
  assert Student.last
  step "I should see \"Janusz\""
  step "I should see \"Poncek\""
end