# coding: utf-8
require 'acceptance/acceptance_helper'

feature 'Teacher school classes' do

  context 'index' do
    before do
      FactoryGirl.create(:school)
      FactoryGirl.create(:semester, :school_id => School.last.id)
      FactoryGirl.create(:teacher, :school_id => School.last.id)
      login('teacher')
    end

    scenario 'form' do
      click_link 'Ustawienia klas'
      page.should have_content 'Dodaj nową klasę'
      page.should have_xpath '//form[@action="/teacher/school_classes"]'
      page.should have_xpath '//input[@value="Zapisz"]'
    end

  end

  context 'create' do
    before do
      FactoryGirl.create(:school)
      FactoryGirl.create(:semester, :school_id => School.last.id)
      FactoryGirl.create(:teacher, :school_id => School.last.id)
      login('teacher')
    end

    scenario 'with valid attributes' do
      click_link 'Ustawienia klas'
      fill_in 'Nazwa', :with => 'G'
      fill_in 'Profil', :with => 'Informatyk'
      fill_in 'Rocznik', :with => '2013'
      click_button 'Zapisz'
      assert SchoolClass.last.active
      assert SchoolClass.last.semester == School.last.semester
      page.should have_content '2013 G Informatyk'
      page.should have_content '2011/2012 Semestr 1 - aktualnie wybrany'
    end

  end

  context 'delete' do
    before do
      FactoryGirl.create(:school)
      FactoryGirl.create(:semester, :school_id => School.last.id)
      FactoryGirl.create(:teacher, :school_id => School.last.id)
      FactoryGirl.create(:school_class, :teacher_id => Teacher.last.id)
      login('teacher')
    end

    scenario 'active school class' do
      click_link 'Ustawienia klas'
      click_link 'Usuń'
      assert SchoolClass.count == 0
      assert Semester.count == 0
      assert !Teacher.first.school_class
      assert !Teacher.first.semester
    end

    scenario 'not active school class' do
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
