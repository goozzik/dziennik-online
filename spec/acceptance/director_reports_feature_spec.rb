# coding: utf-8
require "acceptance/acceptance_helper"

feature "Director reports" do
  before do
    FactoryGirl.create(:school)
    FactoryGirl.create(:director, school_id:School.last.id)
    login "director"
    click_link "Raporty"
  end

  context "semestral" do
    scenario "when there is no active semester in school" do
      click_link "Raport frekwencji klas"
      assert_alert_box "Administrator szkoły nie aktywował jeszcze semestru."
    end

    scenario "when there is data for semester" do
      load_semester
      load_data_for_school_semester_report
      click_link "Raport frekwencji klas"
      save_and_open_page 
      1.upto(3) do |i|
        page.should have_xpath "//table[#{i}]/tr[2]/td[1][contains(text(), '#{i} G')]"
        page.should have_xpath "//table[#{i}]/tr[2]/td[2][contains(text(), '33.33')]"
        page.should have_xpath "//table[#{i}]/tr[2]/td[3][contains(text(), '270')]"
        page.should have_xpath "//table[#{i}]/tr[2]/td[4][contains(text(), '180')]"
        page.should have_xpath "//table[#{i}]/tr[2]/td[5][contains(text(), '0')]"
        page.should have_xpath "//table[#{i}]/tr[2]/td[6][contains(text(), '45')]"
      end
    end

    scenario "when there is data for year" do
      load_semester
      load_second_semester
      load_data_for_school_year_report
      click_link "Raport frekwencji klas"
      save_and_open_page 
      [3, 6, 9].each do |i|
        page.should have_xpath "//table[#{i}]/tr[2]/td[1][contains(text(), '#{i/3} G')]"
        page.should have_xpath "//table[#{i}]/tr[2]/td[2][contains(text(), '33.33')]"
        page.should have_xpath "//table[#{i}]/tr[2]/td[3][contains(text(), '540')]"
        page.should have_xpath "//table[#{i}]/tr[2]/td[4][contains(text(), '360')]"
        page.should have_xpath "//table[#{i}]/tr[2]/td[5][contains(text(), '0')]"
        page.should have_xpath "//table[#{i}]/tr[2]/td[6][contains(text(), '90')]"
      end
    end

  end

end
