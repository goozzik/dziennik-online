# coding: utf-8
require 'acceptance/acceptance_helper'

feature 'Teacher reports' do

  let!(:school) { create(:school) }
  let!(:semester) { create(:semester, school: school) }
  let!(:teacher) { create(:teacher, school: school) }
  let!(:profile) { load_profile }

  context "index" do
    before do
      login "teacher"
    end

    scenario "when teacher has no school class set" do
      page.should_not have_content 'Raporty'
    end

    scenario "when school class has no students" do
      create(:school_class, teacher: teacher)
      reload_page
      click_link "Raporty"
      assert_alert_box "Najpierw dodaj uczniów."
    end

    scenario "when there is data for absences and semestral marks" do
      school_class = create(:school_class, teacher: teacher)
      load_data_for_school_class_semester_report(school_class)
      reload_page
      click_link "Raporty"
      page.should have_xpath "//tr[6]/th[2][contains(text(), '33.33')]"
      page.should have_xpath "//tr[6]/th[3][contains(text(), '270')]"
      page.should have_xpath "//tr[6]/th[4][contains(text(), '180')]"
      page.should have_xpath "//tr[6]/th[5][contains(text(), '0')]"
      page.should have_xpath "//tr[6]/th[6][contains(text(), '45')]"
      page.should have_xpath "//tr[6]/th[7][contains(text(), '3.5')]"
      page.should have_xpath "//tr[6]/th[8][contains(text(), '3')]"
      page.should have_xpath "//tr[6]/th[9][contains(text(), '3')]"
      page.should have_xpath "//tr[6]/th[10][contains(text(), '3')]"
      page.should have_xpath "//tr[6]/th[11][contains(text(), '3')]"
      page.should have_xpath "//tr[6]/th[12][contains(text(), '3')]"
      page.should have_xpath "//tr[6]/th[13][contains(text(), '3')]"
      page.should have_xpath "//tr[6]/th[14][contains(text(), '0')]"
    end

    scenario "when there is data for school class year report" do
      create(:semester, semester: 2, school: school)
      school_class = create(:school_class, teacher: teacher)
      load_data_for_school_class_year_report(school_class)
      reload_page
      click_link "Raporty"
      page.should have_xpath "//table[3]/tr[6]/th[2][contains(text(), '33.33')]"
      page.should have_xpath "//table[3]/tr[6]/th[3][contains(text(), '270')]"
      page.should have_xpath "//table[3]/tr[6]/th[4][contains(text(), '180')]"
      page.should have_xpath "//table[3]/tr[6]/th[5][contains(text(), '0')]"
      page.should have_xpath "//table[3]/tr[6]/th[6][contains(text(), '45')]"
      page.should have_xpath "//table[3]/tr[6]/th[7][contains(text(), '3.50')]"
      page.should have_xpath "//table[3]/tr[6]/th[8][contains(text(), '3')]"
      page.should have_xpath "//table[3]/tr[6]/th[9][contains(text(), '3')]"
      page.should have_xpath "//table[3]/tr[6]/th[10][contains(text(), '3')]"
      page.should have_xpath "//table[3]/tr[6]/th[11][contains(text(), '3')]"
      page.should have_xpath "//table[3]/tr[6]/th[12][contains(text(), '3')]"
      page.should have_xpath "//table[3]/tr[6]/th[13][contains(text(), '3')]"
      page.should have_xpath "//table[3]/tr[6]/th[14][contains(text(), '0')]"
    end

    scenario "when there is no data" do
      school_class = create(:school_class, teacher: teacher)
      create(:student, school_class: school_class)
      reload_page
      click_link "Raporty"
      page.should have_xpath "//tr[4]/th[2][contains(text(), '--')]"
      page.should have_xpath "//tr[4]/th[3][contains(text(), '0')]"
      page.should have_xpath "//tr[4]/th[4][contains(text(), '0')]"
      page.should have_xpath "//tr[4]/th[5][contains(text(), '0')]"
      page.should have_xpath "//tr[4]/th[6][contains(text(), '0')]"
      page.should have_xpath "//tr[4]/th[7][contains(text(), '--')]"
      page.should have_xpath "//tr[4]/th[8][contains(text(), '0')]"
      page.should have_xpath "//tr[4]/th[9][contains(text(), '0')]"
      page.should have_xpath "//tr[4]/th[10][contains(text(), '0')]"
      page.should have_xpath "//tr[4]/th[11][contains(text(), '0')]"
      page.should have_xpath "//tr[4]/th[12][contains(text(), '0')]"
      page.should have_xpath "//tr[4]/th[13][contains(text(), '0')]"
      page.should have_xpath "//tr[4]/th[14][contains(text(), '0')]"
    end
  end

end
