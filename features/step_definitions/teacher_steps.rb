#coding: utf-8
Then /^I should see teacher navigation$/ do
  assert page.has_xpath?("//div[@id='navigation']")
end

Then /^I should see teacher icon navigation$/ do
  assert page.has_xpath?("//a[@href='teacher/subjects']/img[@src='/assets/menu_01.png'][@class='home_menu']")
  assert page.has_xpath?("//a[@href='teacher/absences']/img[@src='/assets/menu_02.png'][@class='home_menu']")
  assert page.has_xpath?("//a[@href='teacher/time_tables']/img[@src='/assets/menu_03.png'][@class='home_menu']")
  assert page.has_xpath?("//a[@href='teacher/subject_teachers']/img[@src='/assets/menu_04.png'][@class='home_menu']")
  assert page.has_xpath?("//a[@href='teacher/documents']/img[@src='/assets/menu_05.png'][@class='home_menu']")
  assert page.has_xpath?("//a[@href='teacher/documents']/img[@src='/assets/menu_06.png'][@class='home_menu']")
  assert page.has_xpath?("//a[@href='']/img[@src='/assets/menu_07.png'][@class='home_menu']")
  assert page.has_xpath?("//a[@href='teacher/school_classes']/img[@src='/assets/menu_08.png'][@class='home_menu']")
  assert page.has_xpath?("//a[@href='teacher/students']/img[@src='/assets/menu_09.png'][@class='home_menu']")
  assert page.has_xpath?("//a[@href='']/img[@src='/assets/menu_11.png'][@class='home_menu']")
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
  visit('/teacher/school_classes')
  click_button('Dodaj nowy semestr')
end

Then /^first semester should be unactive and new one should be active$/ do
  assert !Semester.first.active
  assert Semester.last.active
end

When /^I delete class$/ do
  visit('/teacher/school_classes')
  click_link('Usuń')
end

Then /^class and semester should be deleted$/ do
  assert SchoolClass.count == 0
  assert Semester.count == 0
end

When /^I delete semester$/ do
  visit('/teacher/school_classes')
  click_button('Usuń')
end

Then /^this semester should not exist$/ do
  assert Semester.count == 0
end

Then /^I should have not set up current semester$/ do
  assert !Teacher.first.semester
end

Then /^I should have not set up current semester and school class$/ do
  assert !Teacher.first.school_class
  assert !Teacher.first.semester
end

Then /^first class and semester should be deleted$/ do
  assert SchoolClass.count == 1
  assert Semester.count == 1
end

Then /^I should have set up current semester and school class$/ do
  assert Teacher.first.school_class.active
  assert Teacher.first.semester.active
end

Then /^this first semester should not exist$/ do
  assert Semester.count == 1
end

Then /^I should have set up current semester$/ do
  assert Teacher.first.semester.active
end

When /^I set first semester as active$/ do
  visit('/teacher/school_classes')
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
  visit('/teacher/students')
  fill_in('Imię', :with => 'Janusz')
  fill_in('Nazwisko', :with => 'Poncek')
  click_button("Dodaj")
end

Then /^I should have student$/ do
  assert Student.last
  step "I should see \"Janusz\""
  step "I should see \"Poncek\""
end

When /^I create description$/ do
  visit("/teacher/subjects/#{Subject.last.id}")
  fill_in('Typ', :with => 'Kartkówka')
  fill_in('Opis', :with => 'Trygonometria')
  fill_in('Kolor', :with => 'zielony')
  click_button("Stwórz")
end

Then /^I should see new description$/ do
  assert page.has_content?("Kart")
end

When /^I add mark$/ do
  visit('/teacher/subjects/' + Subject.last.id.to_s)
end

Then /^I should see that student have mark "([^"]*)"$/ do |mark|
  step "I should see \"#{mark}\""
end

When /^I update mark$/ do
  #TODO
end

Then /^I should see that student have average mark "([^"]*)"$/ do |mark|
  step "I should see \"#{mark}\""
end

Then /^I should see may absences$/ do
  assert page.has_content?("2012-05-07")
  assert page.has_xpath?("//td[@class='absence'][contains(text(), \"33\")]")
  assert page.has_xpath?("//td[@class='absence'][contains(text(), \"6\")]")
  assert page.has_xpath?("//td[@class='absence'][contains(text(), \"2\")]")
  assert page.has_content?("75.76")
  assert page.has_content?("24")
  assert page.has_content?("8")
end

When /^I follow link for next month$/ do
  click_link("Następny miesiąc >>")
end

Then /^I should see june absences$/ do
  step "I should see \"2012-06-04\""
end

When /^I follow link for previous month$/ do
  click_link("<< Poprzedni miesiąc")
end

Then /^I should see april absences$/ do
  step "I should see \"2012-04-02\""
end

Then /^I should see create new time table button$/ do
  assert page.has_xpath?("//input[@type='submit'][@value='Dodaj nowy dzień']")
end

When /^I create time table$/ do
end

Then /^I should see new time table$/ do
end

Then /^I should see monday time table$/ do
  assert page.has_content?("Poniedziałek")
  assert page.has_xpath?("//td[@class='lesson_number'][contains(text(), '0')]")
  assert page.has_xpath?("//td[@class='lesson_number'][contains(text(), '1')]")
  assert page.has_xpath?("//td[@class='lesson_name'][contains(text(), 'Matematyka')]")
end

When /^I delete time table$/ do
  step "I go to the teacher time tables index page"
  click_link("Usuń")
end

Then /^I should not see monday time table$/ do
  assert !page.has_content?("Poniedziałek")
  assert !page.has_xpath?("//td[@class='lesson_number'][contains(text(), '0')]")
  assert !page.has_xpath?("//td[@class='lesson_number'][contains(text(), '1')]")
  assert !page.has_xpath?("//td[@class='lesson_name'][contains(text(), 'Matematyka')]")
end

Then /^I should see first monday and second tuesday time table$/ do
  assert page.body =~ /Poniedziałek.*Wtorek/m
end

Then /^I should see that I dont have any documents$/ do
  step "I should see \"Ta klasa nie ma żadnych plików. Możesz dodać plik poprzez poniższy formularz.\""
end

When /^I upload document$/ do
  visit('/teacher/documents')
  fill_in('Nazwa', :with => 'trollface')
  fill_in('Opis', :with => 'Test trollface jpeg file for cucumber tests.')
  attach_file('Wybierz plik', "#{Rails.root}/features/fixtures/test.jpeg")
  click_button('Wyślij')
end

Then /^I should see that I have uploaded documents$/ do
  step "I should see \"trollface\""
  step "I should see \"Test trollface jpeg file for cucumber tests.\""
end

Given /^I have document$/ do
  step "I upload document"
end

When /^I delete document$/ do
  click_link("Usuń")
end

When /^I delete student$/ do
  visit('/teacher/students')
  click_link("Usuń")
end

Then /^I should not see student$/ do
  assert !page.has_content?("Jacek")
end
