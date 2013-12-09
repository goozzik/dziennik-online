# coding: utf-8
require 'acceptance/acceptance_helper'

# locahost:3000/admin/school
feature "Admin school" do

  context "show" do
    let!(:school) { create(:school) }
    let!(:admin) { create(:admin, school: school) }
    before { login "admin" }

    scenario "when there is no semester" do
      click_link "Ustawienia szkoły"
      assert_alert_box "Szkoła nie ma ustawionego semestru!"
    end

    scenario "when there is one semester it should be active" do
      create(:semester, school: school)
      click_link "Ustawienia szkoły"
      page.should have_content "2012/2013"
      page.should have_xpath "//a[@class='btn btn-mini disabled'][contains(text(), 'Ustaw jako aktywny')]"
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
            create(:semester, school: school)
            select "2", from: "semester_semester"
            click_button "Zapisz"
            page.should have_content "2012/2013"
            page.should have_xpath "//a[@class='btn btn-mini ']"
          end

          scenario "when there is no semester yet" do
            click_button "Zapisz"
            page.should have_content "2012/2013"
            page.should have_xpath "//a[@class='btn btn-mini disabled'][contains(text(), 'Ustaw jako aktywny')]"
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
            page.should have_content "zbyt duża różnica"
          end

          scenario "when there is already similar semester" do
            FactoryGirl.create(:semester, semester: 1, start_year: 2012, end_year: 2013, school_id: School.last.id)
            fill_in "semester_start_year", with: "2012"
            fill_in "semester_end_year", with: "2013"
            select "1", from: "semester_semester"
            click_button "Zapisz"
            page.should have_content "już istnieje"
          end
        end

        scenario "cancel" do
          click_link "Anuluj"
          page.should have_content "Ustawienia szkoły"
        end

      end

      context "destroy" do
        let!(:semester) { create(:semester, school: school) }
        before do
          click_link "Ustawienia szkoły"
        end

        scenario "when there is only one semester" do
          click_link "Usuń"
          assert_alert_box "Szkoła nie ma ustawionego semestru!"
        end

        scenario "when there are two semesters" do
          create(:semester, school: school, semester: 2)
          click_link "Usuń"
          page.should_not have_content "Szkoła nie ma ustawionego semestru!"
        end

      end

      context "activate" do
         let!(:semester_1) { create(:semester, school: school, semester: 1) }
         let!(:semester_2) { create(:semester, school: school, semester: 2) }

        scenario "active when semester is not active and not archived" do
          click_link "Ustawienia szkoły"
          semester_1.active.should be_true
          find(:xpath, "//a[@class='btn btn-mini '][contains(text(), 'Ustaw jako aktywny')]").click
          Semester.find_by_semester(2).active.should be_true
        end

        scenario "active when semester is not active and archived" do
          Semester.find_by_semester(2).update_attribute(:archived, true)
          click_link "Ustawienia szkoły"
          find(:xpath, "//a[@class='btn btn-mini disabled'][contains(text(), 'Ustaw jako aktywny')]").click
          Semester.find_by_semester(2).active.should_not be_true
          assert_error_box "Nie można aktywować zarchiwizowanego semestru!"
        end

        #scenario "active not actual year semester" do
        #
        #end
      end

      context "archive" do
        let!(:semester_1) { create(:semester, school: school, semester: 1) }
        let!(:semester_2) { create(:semester, school: school, semester: 2) }

        scenario "archive not archived and not active semester" do
          click_link "Ustawienia szkoły"
          save_and_open_page
          find(:xpath, "//a[@class='btn btn-mini '][contains(text(), 'Archiwizuj')]").click
          Semester.find_by_semester(2).archived.should be_true
        end

        scenario "archive not archived and active semester" do
          click_link "Ustawienia szkoły"
          find(:xpath, "//a[@class='btn btn-mini disabled'][contains(text(), 'Archiwizuj')]").click
          Semester.find_by_semester(1).archived.should_not be_true
          assert_error_box "Nie można zarchiwizować aktywnego semestru!"
        end
      end

      scenario "unarchive" do
        create(:semester, school: school, semester:1)
        semester_2 = create(:semester, school: school, semester:2, archived:true)
        click_link "Ustawienia szkoły"
        click_link "Przywróć"
        Semester.find_by_semester(2).active.should_not be_true
      end
    end
  end

end
