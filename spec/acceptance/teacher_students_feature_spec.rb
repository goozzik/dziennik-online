# coding: utf-8

require 'acceptance/acceptance_helper'

feature 'Teacher students' do

  context 'show' do
    before do
      FactoryGirl.create(:school)
      FactoryGirl.create(:semester, :school_id => School.last.id)
      FactoryGirl.create(:teacher, :school_id => School.last.id)
      FactoryGirl.create(:school_class, :teacher_id => Teacher.last.id)
      FactoryGirl.create(:student, :school_class_id => SchoolClass.last.id)
      login('teacher')
      click_link "Uczniowie"
    end

    scenario 'user information' do
      click_link "Więcej"
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

  context 'update' do
    before do
      FactoryGirl.create(:school)
      FactoryGirl.create(:semester, :school_id => School.last.id)
      FactoryGirl.create(:teacher, :school_id => School.last.id)
      FactoryGirl.create(:school_class, :teacher_id => Teacher.last.id)
      FactoryGirl.create(:student, :school_class_id => SchoolClass.last.id)
      login('teacher')
      click_link "Uczniowie"
    end

    scenario 'with valid attributes' do
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
      FactoryGirl.create(:school)
      FactoryGirl.create(:semester, :school_id => School.last.id)
      FactoryGirl.create(:teacher, :school_id => School.last.id)
      FactoryGirl.create(:school_class, :teacher_id => Teacher.last.id)
      login('teacher')
      click_link "Uczniowie"
    end

    scenario 'validate empty fields' do
      click_button "Zapisz"
      page.should have_content "jest wymagane"
    end

    scenario 'validate pesel' do
      fill_in "student_pesel", :with => "123"
      click_button "Zapisz"
      page.should have_content "Pesel jest nieprawidłowy"
    end

  end

  context "update_password" do
    before do
      FactoryGirl.create(:school)
      FactoryGirl.create(:semester, :school_id => School.last.id)
      FactoryGirl.create(:teacher, :school_id => School.last.id)
      FactoryGirl.create(:school_class, :teacher_id => Teacher.last.id)
      FactoryGirl.create(:student, :school_class_id => SchoolClass.last.id)
      login('teacher')
      click_link "Uczniowie"
      click_link "Zmień hasło"
    end

    scenario "validate teacher password presence" do
      click_button "Zapisz"
      page.should have_content "nie może być puste"
    end

    scenario "validate teacher password" do
      fill_in "student_current_password", :with => "wrongpassword"
      click_button "Zapisz"
      page.should have_content "błędne hasło"
    end

    scenario "validate new password presence" do
      fill_in "student_current_password", :with => "test"
      click_button "Zapisz"
      page.should have_content "nie może być puste"
    end

    scenario "validate password length" do
      fill_in "student_current_password", :with => "test"
      fill_in "student_password", :with => "test"
      click_button "Zapisz"
      page.should have_content "za krótkie"
    end

    scenario "validate password confirmation" do
      fill_in "student_current_password", :with => "test"
      fill_in "student_password", :with => "test123"
      fill_in "student_password_confirmation", :with => "test124"
      click_button "Zapisz"
      page.should have_content "potwierdzenie hasła nie zgadza się"
    end

  end

end
