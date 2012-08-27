# coding: utf-8
require 'acceptance/acceptance_helper'

feature "Director absences" do

  context "index" do
    before do
      FactoryGirl.create(:school)
      FactoryGirl.create(:semester, :school_id => School.last.id)
      FactoryGirl.create(:director, :school_id => School.last.id)
      FactoryGirl.create(:teacher, :school_id => School.last.id)
      FactoryGirl.create(:school_class, :teacher_id => Teacher.last.id)
      login("director")
      click_link "Klasy"
    end

    scenario "there is no students in school class" do
      click_link "Bieżąca frekwencja"
      assert_alert_box "Wychowawca klasy nie dodał jeszcze uczniów."
    end

    scenario "when there is data for school class" do
      load_subject_templates
      subjects = load_subjects_for_school_class
      load_data_for_school_class_semester_report(SchoolClass.last, subjects)
      click_link "Bieżąca frekwencja"
      page.should have_xpath "//tr[3]/td[3][contains(text(), '30')]"
      page.should have_xpath "//tr[3]/td[4][contains(text(), '20')]"
      page.should have_xpath "//tr[3]/td[5][contains(text(), '0')]"
      page.should have_xpath "//tr[3]/td[6][contains(text(), '5')]"
      page.should have_xpath "//tr[6]/th[2][contains(text(), '33.33')]"
      page.should have_xpath "//tr[6]/th[3][contains(text(), '90')]"
      page.should have_xpath "//tr[6]/th[4][contains(text(), '60')]"
      page.should have_xpath "//tr[6]/th[5][contains(text(), '0')]"
      page.should have_xpath "//tr[6]/th[6][contains(text(), '15')]"
    end

    context "month navigation" do
      before do
        FactoryGirl.create(:student, :school_class_id => SchoolClass.last.id)
        click_link "Bieżąca frekwencja"
      end

      scenario "follow next month link" do
        month = Chronic.parse('monday this month')
        next_month = Chronic.parse('monday next month', :now => month)
        find(:xpath, "//a[@href='/director/school_classes/#{SchoolClass.last.id}/absences?date=#{next_month.strftime("%Y-%m-%d")}']").click
        page.should have_content "Frekwencja"
        page.should have_content "#{I18n.t(next_month.strftime("%B"))} #{next_month.year}"
      end

      scenario "follow previous month link" do
        month = Chronic.parse('monday this month')
        previous_month = Chronic.parse('monday last month', :now => month)
        find(:xpath, "//a[@href='/director/school_classes/#{SchoolClass.last.id}/absences?date=#{previous_month.strftime("%Y-%m-%d")}']").click
        page.should have_content "Frekwencja"
        page.should have_content "#{I18n.t(previous_month.strftime("%B"))} #{previous_month.year}"
      end

      scenario "use select list and go to october" do
        FactoryGirl.create(:absence, student_id: Student.last.id, date: "2011-10-03", required: 30, justified: 5)
        click_link "Październik"
        page.should have_xpath "//td[@class='absence'][contains(text(), '30')]"
        page.should have_xpath "//td[@class='absence'][contains(text(), '5')]"
        page.should have_content "Październik 2011"
      end

      scenario "use select list and go to april" do
        FactoryGirl.create(:absence, student_id: Student.last.id, date: "2012-04-02", required: 25, justified: 5)
        click_link "Kwiecień"
        page.should have_xpath "//td[@class='absence'][contains(text(), '25')]"
        page.should have_xpath "//td[@class='absence'][contains(text(), '5')]"
        page.should have_content "Kwiecień 2012"
      end

    end

  end

end
