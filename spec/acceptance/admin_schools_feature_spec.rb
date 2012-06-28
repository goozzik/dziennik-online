# coding: utf-8
require 'acceptance/acceptance_helper'

feature "Admin school" do

  context "show" do
    before do
      FactoryGirl.create(:school)
      FactoryGirl.create(:admin, school_id: School.last.id)
      login "admin"
    end
    
    scenario "when there is no semester" do
      click_link "Ustawienia szkoły" 
      assert_alert_box "Szkoła nie ma ustawionego semestru!"
    end

    scenario "when there is one semester it should be active" do
      FactoryGirl.create(:semester, school_id: School.last.id)
      click_link "Ustawienia szkoły" 
      page.should have_content "2011/2012"
      page.should have_xpath "//a[@class='btn btn-mini disabled']"
    end

    context "semester" do
      context "create" do
        before do
          click_link "Ustawienia szkoły" 
        end

        context "with valid attributes" do
          before do
            fill_in "semester_start_year", with: "2012"
            fill_in "semester_end_year", with: "2013"
            select "1", from: "semester_semester"
          end

          scenario "when there is one semester already" do
            FactoryGirl.create(:semester, school_id: School.last.id)
            click_button "Zapisz"
            page.should have_content "2012/2013"
            page.should have_xpath "//a[@class='btn btn-mini ']"
          end

          scenario "when there is no semester yet" do
            click_button "Zapisz"
            page.should have_content "2012/2013"
            page.should have_xpath "//a[@class='btn btn-mini disabled']"
          end
        end

        context "validate" do

          scenario "when empty start year field" do
            fill_in "semester_end_year", with: "2013"
            select "1", from: "semester_semester"
            click_button "Zapisz"
            page.should have_content "nie może być puste"
          end

          scenario "when empty end year field" do
            fill_in "semester_start_year", with: "2012"
            select "1", from: "semester_semester"
            click_button "Zapisz"
            page.should have_content "nie może być puste"
          end

          scenario "when empty semester field" do
            fill_in "semester_start_year", with: "2012"
            fill_in "semester_end_year", with: "2013"
            click_button "Zapisz"
            page.should have_content "nie może być puste"
          end

          scenario "when end year is earlier than start year" do
            fill_in "semester_start_year", with: "2013"
            fill_in "semester_end_year", with: "2012"
            select "1", from: "semester_semester"
            click_button "Zapisz"
            page.should have_content "musi być późniejszy niż rok rozpoczęcia"
          end

          scenario "when difference between start and end year is more than year" do
            fill_in "semester_start_year", with: "2011"
            fill_in "semester_end_year", with: "2013"
            select "1", from: "semester_semester"
            click_button "Zapisz"
            page.should have_content "zbyt duża rożnica"
          end
        end

        scenario "cancel" do
          click_link "Anuluj"
          page.should have_content "Ustawienia szkoły"
        end

      end

      scenario "destroy" do
        FactoryGirl.create(:semester, school_id: School.last.id)
        click_link "Ustawienia szkoły" 
        click_link "Usuń"
        assert_alert_box "Szkoła nie ma ustawionego semestru!"
      end

      scenario "activate" do
        FactoryGirl.create(:semester, school_id: School.last.id)
        FactoryGirl.create(:semester, school_id: School.last.id, semester: 2)
        click_link "Ustawienia szkoły" 
        assert Semester.find_by_active(true).semester == 1
        find(:xpath, "//a[@class='btn btn-mini '][contains(text(), 'Ustaw jako aktywny')]").click
        assert Semester.find_by_active(true).semester == 2
      end

    end

  end

end
