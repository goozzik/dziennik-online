# coding: utf-8
require 'acceptance/acceptance_helper'

feature 'Teacher semesters' do

  context 'delete' do
    before do
      teacher = FactoryGirl.create(:teacher)
      FactoryGirl.create(:school_class, :teacher_id => teacher.id)
      login('teacher')
    end

    scenario 'Delete active semester' do
      click_link 'Ustawienia klas'
      find(:xpath, "//table/tr[2]/td/a[contains(text(), 'Usuń')]").click
      assert Semester.count == 0
      assert !Teacher.first.semester
    end

    scenario 'Delete not active semester' do
      FactoryGirl.create(:semester, :school_class_id => SchoolClass.last.id)
      click_link 'Ustawienia klas'
      find(:xpath, "//table/tr[2]/td/a[contains(text(), 'Usuń')]").click
      assert Semester.count == 1
      assert Teacher.first.semester
    end

  end

  context 'activate' do
    before do
      teacher = FactoryGirl.create(:teacher)
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

  end

end
