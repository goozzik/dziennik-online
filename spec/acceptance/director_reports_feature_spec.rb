# coding: utf-8
require "acceptance/acceptance_helper"

feature "Director reports" do
  before do
    FactoryGirl.create(:school)
    FactoryGirl.create(:director, school_id:School.last.id)
    login "director"
    click_link "Raporty"
  end

  context "absences" do
    scenario "when there is no active semester in school" do
      click_link "Raport frekwencji klas"
      assert_alert_box "Administrator szkoły nie aktywował jeszcze semestru."
    end

    scenario "when there is data for semester" do
      load_semester
      load_data_for_school_semester_report
      click_link "Raport frekwencji klas"
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

  context "school_class" do
    before do
      load_semester
    end

    scenario "when there is no school class in school" do
      page.should_not have_xpath "//a[contains(text(), 'Raporty klas')]"
    end

    scenario "when there is data for school_class" do
      load_data_for_school_semester_report
      reload_page
      click_link "Raporty klas"
      save_and_open_page
      page.should have_content "Raport nauczania klasy 1 G Informatyk 2015"
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

  end

end
