# coding: utf-8
require 'acceptance/acceptance_helper'

feature 'Teacher semesters' do

  context 'activate' do
    before do
      FactoryGirl.create(:school)
      FactoryGirl.create(:semester, :school_id => School.last.id)
      FactoryGirl.create(:teacher, :school_id => School.last.id)
      FactoryGirl.create(:school_class, :teacher_id => teacher.id)
      login('teacher')
    end

    scenario 'Set semester as active when another is active' do
      FactoryGirl.create(:semester, :school_class_id => SchoolClass.last.id)
      click_link 'Ustawienia klas'
      click_link 'Semestr 1'
      assert Teacher.first.semester_id == Semester.find_by_active(true).id
      assert !Semester.last.active
      page.should have_content 'Semestr 1 - aktualnie wybrany'
    end

    scenario "Set semester as active when it is already active" do
      click_link 'Ustawienia klas'
      click_link 'Semestr 1 - aktualnie wybrany'
      assert Teacher.first.semester_id == Semester.find_by_active(true).id
      assert Semester.last.active
      page.should have_content 'Semestr 1 - aktualnie wybrany'
    end

  end

end
