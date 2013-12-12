# coding: utf-8
require 'acceptance/acceptance_helper'

feature "absences" do

  context "index" do
    let!(:school) { create(:school) }
    let!(:semester) { create(:semester, school: school) }
    let!(:director) { create(:director, school: school) }
    let!(:teacher) { create(:teacher, school: school) }
    let!(:profile) { create(:profile_template, school: school) }
    let!(:school_class) { create(:school_class,
                                 teacher: teacher, profile: "Technik awionik") }
    before do
      login("director")
      click_link "Klasy"
    end

    scenario "there is no students in school class" do
      click_link "Bieżąca frekwencja"
      assert_alert_box "Wychowawca klasy nie dodał jeszcze uczniów."
    end

    scenario "when there is data for school class" do
      load_data_for_school_class_semester_report(school_class)
      click_link "Bieżąca frekwencja"
      page.should have_xpath "//tr[3]/td[3][contains(text(), '30')]"
      page.should have_xpath "//tr[3]/td[4][contains(text(), '20')]"
      page.should have_xpath "//tr[3]/td[5][contains(text(), '0')]"
      page.should have_xpath "//tr[3]/td[6][contains(text(), '5')]"
      page.should have_xpath "//tr[6]/th[2][contains(text(), '33.33')]"
      page.should have_xpath "//tr[6]/th[3][contains(text(), '270')]"
      page.should have_xpath "//tr[6]/th[4][contains(text(), '180')]"
      page.should have_xpath "//tr[6]/th[5][contains(text(), '0')]"
      page.should have_xpath "//tr[6]/th[6][contains(text(), '45')]"
    end

    context "month navigation" do
      let!(:student) { create(:student, school_class: school_class) }
      before do
        click_link "Bieżąca frekwencja"
      end

      scenario "follow next month link" do
        next_month = Chronic.parse('monday next month')
        find(:xpath, "//a[@href='/director/school_classes/#{school_class.id}/absences?month=#{next_month.month}']").click
        page.should have_content "Frekwencja"
        page.should have_content "#{I18n.t(next_month.strftime("%B"))}"
      end

      scenario "follow previous month link" do
        previous_month = Chronic.parse('monday last month')
        find(:xpath, "//a[@href='/director/school_classes/#{school_class.id}/absences?month=#{previous_month.month}']").click
        page.should have_content "Frekwencja"
        page.should have_content "#{I18n.t(previous_month.strftime("%B"))}"
      end

      scenario "use select list and go to october" do
        create(:absence, student: student, month: 10, week: 1,
               required: 30, justified: 5)
        click_link "Październik"
        page.should have_xpath "//td[@class='absence 1 required_absence'][contains(text(), '30')]"
        page.should have_xpath "//td[@class='absence'][contains(text(), '5')]"
        page.should have_content "Październik"
      end

      scenario "use select list and go to april" do
        create(:absence, student: student, month: 4, week: 1,
               required: 25, justified: 5)
        click_link "Kwiecień"
        page.should have_xpath "//td[@class='absence 1 required_absence'][contains(text(), '25')]"
        page.should have_xpath "//td[@class='absence'][contains(text(), '5')]"
        page.should have_content "Kwiecień"
      end
    end
  end

end
