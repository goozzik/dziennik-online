# coding: utf-8

require 'acceptance/acceptance_helper'

feature 'Teacher students' do

  context "index" do
    let!(:school) { create(:school) }
    let!(:semester) { create(:semester, school: school) }
    let!(:teacher) { create(:teacher, school: school) }
    let!(:profle) { load_profile }
    let!(:school_class) { create(:school_class, teacher: teacher) }

    scenario "info when school class has no students" do
      login('teacher')
      create(:school_class, teacher: teacher)
      click_link "Uczniowie"
      assert_info_box("Klasa nie ma uczniów.")
    end

    context 'show' do
      let!(:student) { create(:student, school_class: school_class) }
      before do
        login('teacher')
        click_link "Uczniowie"
        click_link "Więcej"
      end

      scenario 'user information' do
        assert_page_header "Informacje o uczniu"
        page.should have_content "Jacek"
        page.should have_content "Placek"
      end

      scenario "click back button" do
        click_button "Wróć"
        assert_page_header "Uczniowie"
      end
    end

    context 'update' do
      let!(:student) { create(:student, school_class: school_class) }
      before do
        login('teacher')
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
      let!(:school_class) { create(:school_class, teacher: teacher,
                                   school: school) }
      before do
        login('teacher')
        click_link "Uczniowie"
      end

      scenario 'validate empty fields' do
        click_button "Zapisz"
        page.should have_content "jest wymagane"
      end
    end

    context "update_password" do
      let!(:school_class) { create(:school_class, teacher: teacher) }
      let!(:student) { create(:student, school_class: school_class) }
      before do
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
        fill_in "student_current_password", :with => teacher.username
        click_button "Zapisz"
        page.should have_content "nie może być puste"
      end

      scenario "validate password length" do
        fill_in "student_current_password", :with => teacher.username
        fill_in "student_password", :with => "test"
        click_button "Zapisz"
        page.should have_content "za krótkie"
      end

      scenario "validate password confirmation" do
        fill_in "student_current_password", :with => teacher.username
        fill_in "student_password", :with => "test123"
        fill_in "student_password_confirmation", :with => "test124"
        click_button "Zapisz"
        page.should have_content "potwierdzenie hasła nie zgadza się"
      end
    end
  end

end
