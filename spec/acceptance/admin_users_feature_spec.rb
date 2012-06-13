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
        page.should have_content "nie może być puste"
      end

    end

    scenario "destroy" do
      FactoryGirl.create(:teacher, :school_id => School.last.id)
      click_link "Użytkownicy"
      find(:xpath, "//table[1]//a[@data-method='delete']").click
      save_and_open_page
      assert_info_box "Szkoła nie posiada nauczycieli."
    end

  end

end
