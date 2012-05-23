# coding: utf-8
require 'acceptance/acceptance_helper'

feature 'Teacher school classes' do

  context 'index' do
    before do
      FactoryGirl.create(:teacher)
      login('teacher')
    end

    scenario 'Index' do
      click_link 'Ustawienia klas'
      page.should have_content 'Dodaj nową klasę'
      page.should have_xpath '//form[@action="/teacher/school_classes"]'
      page.should have_xpath '//input[@value="Stwórz"]'
    end

  end

  context 'create' do
    before do
      FactoryGirl.create(:teacher)
      login('teacher')
    end

    scenario 'Create class' do
      click_link 'Ustawienia klas'
      fill_in 'Nazwa', :with => 'G'
      fill_in 'Profil', :with => 'Informatyk'
      fill_in 'Rocznik', :with => '2013'
      click_button 'Stwórz'
      school_class = SchoolClass.first(:conditions => ['name = ? AND profile = ? AND yearbook = ?', 'G', 'Informatyk', '2013'])
      assert Teacher.last.school_class == school_class
      assert school_class.active
      semester = Semester.first(:conditions => ['school_class_id = ?', school_class.id])
      assert Teacher.last.semester == semester
      assert semester.active
      page.should have_content 'G 2013'
      page.should have_content 'Semestr 1 - aktualnie wybrany'
    end

    scenario 'Create semester when I have class' do
      FactoryGirl.create(:school_class, :teacher_id => Teacher.last.id)
      click_link 'Ustawienia klas'
      click_button 'Dodaj nowy semestr'
      assert !Semester.first.active
      assert Semester.last.active
      page.should have_content 'Semestr 2'
    end

  end

  context 'delete' do
    before do
      teacher = FactoryGirl.create(:teacher)
      FactoryGirl.create(:school_class, :teacher_id => teacher.id)
      login('teacher')
    end

    scenario 'Delete active school class' do
      click_link 'Ustawienia klas'
      click_link 'Usuń'
      assert SchoolClass.count == 0
      assert Semester.count == 0
      assert !Teacher.first.school_class
      assert !Teacher.first.semester
    end

    scenario 'Delete not active school class' do
      FactoryGirl.create(:school_class, :teacher_id => Teacher.last.id)
      click_link 'Ustawienia klas'
      click_link 'Usuń'
      assert SchoolClass.count == 1
      assert Semester.count == 1
      assert Teacher.first.school_class.active
      assert Teacher.first.semester.active
    end

  end

end
