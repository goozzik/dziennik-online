# coding: utf-8

require 'acceptance/acceptance_helper'

feature 'Teacher students' do

  context 'show' do
    before do
      school = FactoryGirl.create(:school)
      teacher = FactoryGirl.create(:teacher, :school_id => school.id)
      school_class = FactoryGirl.create(:school_class, :teacher_id => teacher.id)
      student = FactoryGirl.create(:student, :school_class_id => SchoolClass.last.id)
      login('teacher')
      click_link "Uczniowie"
    end

    scenario 'All user information' do
      click_link "Więcej"
      page.should have_content "student"
      page.should have_content "Jacek"
      page.should have_content "Placek"
      page.should have_content '93052334123'
      page.should have_content '1'
      page.should have_content 'Słowackiego 3/3'
      page.should have_content 'Częstochowa'
      page.should have_content '42-200'
      page.should have_content 'Śląskie'
      page.should have_content '34233123'
    end

  end

  context 'edit' do
    before do
      school = FactoryGirl.create(:school)
      teacher = FactoryGirl.create(:teacher, :school_id => school.id)
      school_class = FactoryGirl.create(:school_class, :teacher_id => teacher.id)
      student = FactoryGirl.create(:student, :school_class_id => SchoolClass.last.id)
      login('teacher')
      click_link "Uczniowie"
    end

    scenario 'Update student info' do
      click_link "Edytuj"
      fill_in "student_first_name", :with => 'Tomasz'
      fill_in "student_last_name", :with => 'Krawczyk'
      click_button "Zapisz"
      page.should have_content "Tomasz"
      page.should have_content "Krawczyk"
    end

  end

  context 'create' do
    before do
      school = FactoryGirl.create(:school)
      teacher = FactoryGirl.create(:teacher, :school_id => school.id)
      school_class = FactoryGirl.create(:school_class, :teacher_id => teacher.id)
      login('teacher')
      click_link "Uczniowie"
    end

    scenario 'Validate empty fields' do
      click_button "Zapisz"
      page.should have_content "jest wymagane"
    end

    scenario 'Validate pesel' do
      fill_in "student_pesel", :with => "123"
      click_button "Zapisz"
      page.should have_content "Pesel jest nieprawidłowy"
    end

  end

end
