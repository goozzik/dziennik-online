# coding: utf-8

require 'acceptance/acceptance_helper'

feature 'Teacher students' do

  context "index" do
    before do
      FactoryGirl.create(:school)
      FactoryGirl.create(:semester, :school_id => School.last.id)
      FactoryGirl.create(:teacher, :school_id => School.last.id)
      login('teacher')
    end

    scenario "info when school class is not set" do
      click_link "Uczniowie"
      assert_alert_box("Najpierw dodaj klasę!")
    end

    scenario "info when school class have no students" do
      FactoryGirl.create(:school_class, :teacher_id => Teacher.last.id)
      click_link "Uczniowie"
      assert_info_box("Klasa nie ma uczniów.")
    end

    context 'show' do
      before do
        FactoryGirl.create(:school_class, :teacher_id => Teacher.last.id)
        FactoryGirl.create(:student, :school_class_id => SchoolClass.last.id)
        click_link "Uczniowie"
        click_link "Więcej"
      end

      scenario 'user information' do
        assert_page_header "Informacje o uczniu"
        page.should have_content "Jacek"
        page.should have_content "Placek"
        page.should have_content '93052334123'
        page.should have_content '1'
        page.should have_content 'Słowackiego 3/3'
        page.should have_content 'Częstochowa'
        page.should have_content '42-200'
        page.should have_content 'Śląskie'
      end

      scenario "click back button" do
        click_button "Wróć"
        assert_page_header "Uczniowie"
      end

    end

    context 'update' do
      before do
        FactoryGirl.create(:school_class, :teacher_id => Teacher.last.id)
        FactoryGirl.create(:student, :school_class_id => SchoolClass.last.id)
        click_link "Uczniowie"
        click_link "Edytuj"
      end

      scenario 'with valid attributes' do
        fill_in "student_first_name", :with => 'Tomasz'
        fill_in "student_last_name", :with => 'Krawczyk'
        click_button "Zapisz"
        page.should have_content "Tomasz"
        page.should have_content "Krawczyk"
      end

      scenario 'validate empty fields' do
        fill_in "student_first_name", :with => ''
        fill_in "student_last_name", :with => ''
        click_button "Zapisz"
        page.should have_content "jest wymagane"
      end

    end

    context 'create' do
      before do
        FactoryGirl.create(:school_class, :teacher_id => Teacher.last.id)
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
        FactoryGirl.create(:school_class, :teacher_id => Teacher.last.id)
        FactoryGirl.create(:student, :school_class_id => SchoolClass.last.id)
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
        fill_in "student_current_password", :with => Teacher.last.username
        click_button "Zapisz"
        page.should have_content "nie może być puste"
      end

      scenario "validate password length" do
        fill_in "student_current_password", :with => Teacher.last.username
        fill_in "student_password", :with => "test"
        click_button "Zapisz"
        page.should have_content "za krótkie"
      end

      scenario "validate password confirmation" do
        fill_in "student_current_password", :with => Teacher.last.username
        fill_in "student_password", :with => "test123"
        fill_in "student_password_confirmation", :with => "test124"
        click_button "Zapisz"
        page.should have_content "potwierdzenie hasła nie zgadza się"
      end

    end

  end

end
