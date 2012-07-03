# coding: utf-8

require "acceptance/acceptance_helper"

feature "Student reports" do

  context "index" do
    before do
      FactoryGirl.create(:school)
      if Time.now.month > 9
        FactoryGirl.create(:semester, school_id:School.last.id, semester:1, start_year:Time.now.year, end_year: Time.now.year+1)
      else
        FactoryGirl.create(:semester, school_id:School.last.id, semester:2, start_year:Time.now.year-1, end_year: Time.now.year)
      end
      FactoryGirl.create(:teacher, school_id:School.last.id)
      FactoryGirl.create(:school_class, teacher_id:Teacher.last.id)
      FactoryGirl.create(:student, school_class_id:SchoolClass.last.id)
      login "student"
    end

    scenario "when there is data for semester" do
      load_subjects_for_student_semester_report
      load_data_for_student_semester_report(Semester.last)
      click_link "Raporty"
      page.should have_xpath "//tr[3]/td[1][contains(text(), '33.33')]"
      page.should have_xpath "//tr[3]/td[2][contains(text(), '90')]"
      page.should have_xpath "//tr[3]/td[3][contains(text(), '60')]"
      page.should have_xpath "//tr[3]/td[4][contains(text(), '0')]"
      page.should have_xpath "//tr[3]/td[5][contains(text(), '15')]"
      page.should have_xpath "//tr[3]/td[6][contains(text(), '3.5')]"
      page.should have_xpath "//tr[3]/td[7][contains(text(), '1')]"
      page.should have_xpath "//tr[3]/td[8][contains(text(), '1')]"
      page.should have_xpath "//tr[3]/td[9][contains(text(), '1')]"
      page.should have_xpath "//tr[3]/td[10][contains(text(), '1')]"
      page.should have_xpath "//tr[3]/td[11][contains(text(), '1')]"
      page.should have_xpath "//tr[3]/td[12][contains(text(), '1')]"
      page.should have_xpath "//tr[3]/td[13][contains(text(), '0')]"
    end

    scenario "when there is data for year" do
      load_subjects_for_student_semester_report
      load_data_for_student_year_report
      click_link "Raporty"
      page.should have_xpath "//h2[contains(text(), 'Podsumowanie roku szkolnego 2011/2012')]"
      page.should have_xpath "//table[3]/tr[3]/td[1][contains(text(), '33.33')]"
      page.should have_xpath "//table[3]/tr[3]/td[2][contains(text(), '180')]"
      page.should have_xpath "//table[3]/tr[3]/td[3][contains(text(), '120')]"
      page.should have_xpath "//table[3]/tr[3]/td[4][contains(text(), '0')]"
      page.should have_xpath "//table[3]/tr[3]/td[5][contains(text(), '30')]"
      page.should have_xpath "//table[3]/tr[3]/td[6][contains(text(), '3.5')]"
      save_and_open_page
      page.should have_xpath "//table[3]/tr[3]/td[7][contains(text(), '1')]"
      page.should have_xpath "//table[3]/tr[3]/td[8][contains(text(), '1')]"
      page.should have_xpath "//table[3]/tr[3]/td[9][contains(text(), '1')]"
      page.should have_xpath "//table[3]/tr[3]/td[10][contains(text(), '1')]"
      page.should have_xpath "//table[3]/tr[3]/td[11][contains(text(), '1')]"
      page.should have_xpath "//table[3]/tr[3]/td[12][contains(text(), '1')]"
      page.should have_xpath "//table[3]/tr[3]/td[13][contains(text(), '0')]"
    end

    scenario "when there is no data" do
      click_link "Raporty"
      page.should have_xpath "//tr[3]/td[1][contains(text(), '--')]"
      page.should have_xpath "//tr[3]/td[2][contains(text(), '0')]"
      page.should have_xpath "//tr[3]/td[3][contains(text(), '0')]"
      page.should have_xpath "//tr[3]/td[4][contains(text(), '0')]"
      page.should have_xpath "//tr[3]/td[5][contains(text(), '0')]"
      page.should have_xpath "//tr[3]/td[6][contains(text(), '--')]"
      page.should have_xpath "//tr[3]/td[7][contains(text(), '0')]"
      page.should have_xpath "//tr[3]/td[8][contains(text(), '0')]"
      page.should have_xpath "//tr[3]/td[9][contains(text(), '0')]"
      page.should have_xpath "//tr[3]/td[10][contains(text(), '0')]"
      page.should have_xpath "//tr[3]/td[11][contains(text(), '0')]"
      page.should have_xpath "//tr[3]/td[12][contains(text(), '0')]"
      page.should have_xpath "//tr[3]/td[13][contains(text(), '0')]"
    end

  end

end
