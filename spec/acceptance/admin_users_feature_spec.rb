# coding: utf-8
require 'acceptance/acceptance_helper'

feature "Admin accounts" do

  context "index" do
    before do
      FactoryGirl.create(:school)
      FactoryGirl.create(:admin, :school_id => School.last.id)
      login "admin"
    end

    scenario "when there is no director/teacher/other admin accounts in school" do
      click_link "Użytkownicy"
      assert_info_box "Szkoła nie posiada dyrektorów."
      assert_info_box "Szkoła nie posiada nauczycieli."
    end

    scenario "when there are director, teacher and other admin" do
      FactoryGirl.create(:director, :school_id => School.last.id)
      FactoryGirl.create(:teacher, :school_id => School.last.id)
      FactoryGirl.create(:admin, :school_id => School.last.id)
      click_link "Użytkownicy"
      page.should have_content "Nauczycieliusz"
      page.should have_content "Dyrektoriusz"
      page.should have_content "Admin"
    end

    context "create" do
      before do
        click_link "Użytkownicy"
      end

      scenario "teacher" do
        fill_in "user_first_name", :with => "Jackob"
        fill_in "user_last_name", :with => "James"
        select "nauczyciel", :from => "user_user_role"
        click_button "Zapisz"
        page.should have_content "Jackob"
      end

      scenario "director" do
        fill_in "user_first_name", :with => "Jackob"
        fill_in "user_last_name", :with => "James"
        select "dyrektor", :from => "user_user_role"
        click_button "Zapisz"
        page.should have_content "Jackob"
      end

      scenario "admin" do
        fill_in "user_first_name", :with => "Jackob"
        fill_in "user_last_name", :with => "James"
        select "administrator", :from => "user_user_role"
        click_button "Zapisz"
        page.should have_content "Jackob"
      end

      scenario "with empty first_name" do
        fill_in "user_last_name", :with => "James"
        select "nauczyciel", :from => "user_user_role"
        click_button "Zapisz"
        page.should have_content "nie może być puste"
      end

      scenario "with empty last_name" do
        fill_in "user_first_name", :with => "James"
        select "nauczyciel", :from => "user_user_role"
        click_button "Zapisz"
        page.should have_content "nie może być puste"
      end

      scenario "with empty user_role" do
        fill_in "user_first_name", :with => "James"
        fill_in "user_last_name", :with => "James"
        click_button "Zapisz"
        page.should have_content "nieprawidłowa rola"
      end

    end

    scenario "destroy" do
      FactoryGirl.create(:teacher, :school_id => School.last.id)
      click_link "Użytkownicy"
      find(:xpath, "//table[1]//a[@data-method='delete']").click
      assert_info_box "Szkoła nie posiada nauczycieli."
    end

    context "update_password" do
      before do
        FactoryGirl.create(:teacher, :school_id => School.last.id)
        click_link "Użytkownicy"
        click_link "Zmień hasło"
      end

      scenario "validate admin password" do
        fill_in "user_current_password", :with => "wrongpassword"
        click_button "Zapisz"
        assert_error_box "Nieprawidłowe hasło!"
      end

      scenario "validate new password presence" do
        fill_in "user_current_password", :with => Admin.last.username
        click_button "Zapisz"
        page.should have_content "nie może być puste"
      end

      scenario "validate password length" do
        fill_in "user_current_password", :with => Admin.last.username
        fill_in "user_password", :with => "test"
        click_button "Zapisz"
        page.should have_content "za krótkie"
      end

      scenario "validate password confirmation" do
        fill_in "user_current_password", :with => Admin.last.username
        fill_in "user_password", :with => "test123"
        fill_in "user_password_confirmation", :with => "test124"
        click_button "Zapisz"
        page.should have_content "potwierdzenie hasła nie zgadza się"
      end

    end

    context "update" do
      before do
        FactoryGirl.create(:teacher, :school_id => School.last.id)
        click_link "Użytkownicy"
        click_link "Edytuj"
      end

      scenario "with valid attributes" do
        fill_in "user_first_name", :with => "Jackob"
        fill_in "user_last_name", :with => "James"
        click_button "Zapisz"
        page.should have_content "Jackob"
      end

      scenario "with blank first name" do
        fill_in "user_first_name", :with => ""
        click_button "Zapisz"
        page.should have_content "nie może być puste"
      end

      scenario "with blank last name" do
        fill_in "user_last_name", :with => ""
        click_button "Zapisz"
        page.should have_content "nie może być puste"
      end

      scenario "with blank login" do
        fill_in "user_username", :with => ""
        click_button "Zapisz"
        page.should have_content "nie może być puste"
      end
    end

  end

end
