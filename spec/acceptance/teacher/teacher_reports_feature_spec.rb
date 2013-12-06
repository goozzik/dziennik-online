# coding: utf-8
require 'acceptance/acceptance_helper'

feature 'Teacher reports' do

  context "index" do
    before do
      FactoryGirl.create(:school)
      load_semester
      load_subject_templates
      FactoryGirl.create(:teacher, school_id:School.last.id)
      login "teacher" 
    end

    scenario "when teacher has no school class set" do
      click_link "Raporty"
      assert_alert_box "Najpierw dodaj klasę."
    end

    scenario "when school class has no students" do
      FactoryGirl.create(:school_class, teacher_id:Teacher.last.id)
      click_link "Raporty"
      assert_alert_box "Najpierw dodaj uczniów."
    end

    scenario "when there is data for absences and semestral marks" do
      school_class = FactoryGirl.create(:school_class, teacher_id:Teacher.last.id)
      subjects = load_subjects_for_school_class(school_class)
      load_data_for_school_class_semester_report(school_class, subjects)
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
      load_second_semester
      school_class = FactoryGirl.create(:school_class, teacher_id:Teacher.last.id)
      subjects = load_subjects_for_school_class(school_class)
      load_data_for_school_class_year_report(school_class, subjects)
      click_link "Raporty"
      page.should have_content "Podsumowanie roku szkolnego 2011/2012"
      page.should have_xpath "//table[3]/tr[6]/th[2][contains(text(), '33.33')]"
      page.should have_xpath "//table[3]/tr[6]/th[3][contains(text(), '540')]"
      page.should have_xpath "//table[3]/tr[6]/th[4][contains(text(), '360')]"
      page.should have_xpath "//table[3]/tr[6]/th[5][contains(text(), '0')]"
      page.should have_xpath "//table[3]/tr[6]/th[6][contains(text(), '90')]"
      page.should have_xpath "//table[3]/tr[6]/th[7][contains(text(), '3.5')]"
      page.should have_xpath "//table[3]/tr[6]/th[8][contains(text(), '3')]"
      page.should have_xpath "//table[3]/tr[6]/th[9][contains(text(), '3')]"
      page.should have_xpath "//table[3]/tr[6]/th[10][contains(text(), '3')]"
      page.should have_xpath "//table[3]/tr[6]/th[11][contains(text(), '3')]"
      page.should have_xpath "//table[3]/tr[6]/th[12][contains(text(), '3')]"
      page.should have_xpath "//table[3]/tr[6]/th[13][contains(text(), '3')]"
      page.should have_xpath "//table[3]/tr[6]/th[14][contains(text(), '0')]"
    end

    scenario "when there is no data" do
      FactoryGirl.create(:school_class, teacher_id:Teacher.last.id)
      FactoryGirl.create(:student, school_class_id:SchoolClass.last.id)
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
