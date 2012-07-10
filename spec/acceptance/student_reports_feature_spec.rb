# coding: utf-8

require "acceptance/acceptance_helper"

feature "Student reports" do

  context "index" do
    before do
      FactoryGirl.create(:school)
      FactoryGirl.create(:teacher, school_id:School.last.id)
      load_semester
      load_subject_templates
      @school_class = FactoryGirl.create(:school_class, teacher_id:Teacher.last.id)
      @subjects = load_subjects_for_school_class(@school_class)
    end

    scenario "when there is data for semester" do
      load_data_for_school_class_semester_report(@school_class, @subjects)
      login "student"
      click_link "Raporty"
      page.should have_xpath "//tr[3]/td[2][contains(text(), '33.33')]"
      page.should have_xpath "//tr[3]/td[3][contains(text(), '90')]"
      page.should have_xpath "//tr[3]/td[4][contains(text(), '60')]"
      page.should have_xpath "//tr[3]/td[5][contains(text(), '0')]"
      page.should have_xpath "//tr[3]/td[6][contains(text(), '15')]"
      page.should have_xpath "//tr[3]/td[7][contains(text(), '3.5')]"
      page.should have_xpath "//tr[3]/td[8][contains(text(), '1')]"
      page.should have_xpath "//tr[3]/td[9][contains(text(), '1')]"
      page.should have_xpath "//tr[3]/td[10][contains(text(), '1')]"
      page.should have_xpath "//tr[3]/td[11][contains(text(), '1')]"
      page.should have_xpath "//tr[3]/td[12][contains(text(), '1')]"
      page.should have_xpath "//tr[3]/td[13][contains(text(), '1')]"
      page.should have_xpath "//tr[3]/td[14][contains(text(), '0')]"
      # part for school class
      page.should have_xpath "//tr[4]/td[2][contains(text(), '33.33')]"
      page.should have_xpath "//tr[4]/td[3][contains(text(), '270')]"
      page.should have_xpath "//tr[4]/td[4][contains(text(), '180')]"
      page.should have_xpath "//tr[4]/td[5][contains(text(), '0')]"
      page.should have_xpath "//tr[4]/td[6][contains(text(), '45')]"
      page.should have_xpath "//tr[4]/td[7][contains(text(), '3.5')]"
      page.should have_xpath "//tr[4]/td[8][contains(text(), '3')]"
      page.should have_xpath "//tr[4]/td[9][contains(text(), '3')]"
      page.should have_xpath "//tr[4]/td[10][contains(text(), '3')]"
      page.should have_xpath "//tr[4]/td[11][contains(text(), '3')]"
      page.should have_xpath "//tr[4]/td[12][contains(text(), '3')]"
      page.should have_xpath "//tr[4]/td[13][contains(text(), '3')]"
      page.should have_xpath "//tr[4]/td[14][contains(text(), '0')]"
    end

    scenario "when there is data for year" do
      load_second_semester
      load_data_for_school_class_year_report(@school_class, @subjects)
      login "student"
      click_link "Raporty"
      page.should have_xpath "//h2[contains(text(), 'Podsumowanie roku szkolnego 2011/2012')]"
      page.should have_xpath "//table[3]/tr[3]/td[2][contains(text(), '33.33')]"
      page.should have_xpath "//table[3]/tr[3]/td[3][contains(text(), '180')]"
      page.should have_xpath "//table[3]/tr[3]/td[4][contains(text(), '120')]"
      page.should have_xpath "//table[3]/tr[3]/td[5][contains(text(), '0')]"
      page.should have_xpath "//table[3]/tr[3]/td[6][contains(text(), '30')]"
      page.should have_xpath "//table[3]/tr[3]/td[7][contains(text(), '3.5')]"
      page.should have_xpath "//table[3]/tr[3]/td[8][contains(text(), '1')]"
      page.should have_xpath "//table[3]/tr[3]/td[9][contains(text(), '1')]"
      page.should have_xpath "//table[3]/tr[3]/td[10][contains(text(), '1')]"
      page.should have_xpath "//table[3]/tr[3]/td[11][contains(text(), '1')]"
      page.should have_xpath "//table[3]/tr[3]/td[12][contains(text(), '1')]"
      page.should have_xpath "//table[3]/tr[3]/td[13][contains(text(), '1')]"
      page.should have_xpath "//table[3]/tr[3]/td[14][contains(text(), '0')]"
      # part for school class
      page.should have_xpath "//table[3]/tr[4]/td[2][contains(text(), '33.33')]"
      page.should have_xpath "//table[3]/tr[4]/td[3][contains(text(), '540')]"
      page.should have_xpath "//table[3]/tr[4]/td[4][contains(text(), '360')]"
      page.should have_xpath "//table[3]/tr[4]/td[5][contains(text(), '0')]"
      page.should have_xpath "//table[3]/tr[4]/td[6][contains(text(), '90')]"
      page.should have_xpath "//table[3]/tr[4]/td[7][contains(text(), '3.5')]"
      page.should have_xpath "//table[3]/tr[4]/td[8][contains(text(), '3')]"
      page.should have_xpath "//table[3]/tr[4]/td[9][contains(text(), '3')]"
      page.should have_xpath "//table[3]/tr[4]/td[10][contains(text(), '3')]"
      page.should have_xpath "//table[3]/tr[4]/td[11][contains(text(), '3')]"
      page.should have_xpath "//table[3]/tr[4]/td[12][contains(text(), '3')]"
      page.should have_xpath "//table[3]/tr[4]/td[13][contains(text(), '3')]"
      page.should have_xpath "//table[3]/tr[4]/td[14][contains(text(), '0')]"
    end

    scenario "when there is no data" do
      FactoryGirl.create(:student, school_class_id:@school_class.id)
      login "student"
      click_link "Raporty"
      page.should have_xpath "//tr[3]/td[2][contains(text(), '--')]"
      page.should have_xpath "//tr[3]/td[3][contains(text(), '0')]"
      page.should have_xpath "//tr[3]/td[4][contains(text(), '0')]"
      page.should have_xpath "//tr[3]/td[5][contains(text(), '0')]"
      page.should have_xpath "//tr[3]/td[6][contains(text(), '0')]"
      page.should have_xpath "//tr[3]/td[7][contains(text(), '--')]"
      page.should have_xpath "//tr[3]/td[8][contains(text(), '0')]"
      page.should have_xpath "//tr[3]/td[9][contains(text(), '0')]"
      page.should have_xpath "//tr[3]/td[10][contains(text(), '0')]"
      page.should have_xpath "//tr[3]/td[11][contains(text(), '0')]"
      page.should have_xpath "//tr[3]/td[12][contains(text(), '0')]"
      page.should have_xpath "//tr[3]/td[13][contains(text(), '0')]"
      page.should have_xpath "//tr[3]/td[14][contains(text(), '0')]"
    end

  end

end
