# coding: utf-8

require "acceptance/acceptance_helper"

feature "Student reports" do

  context "index" do
    before do
      FactoryGirl.create(:school)
      FactoryGirl.create(:semester, school_id:School.last.id, semester:Time.now.month > 9 ? 1 : 2 )
      FactoryGirl.create(:teacher, school_id:School.last.id)
      FactoryGirl.create(:school_class, teacher_id:Teacher.last.id)
      FactoryGirl.create(:student, school_class_id:SchoolClass.last.id)
      login "student"
    end

    scenario "when there is data for absences and semestral marks" do
      time = Chronic.parse('monday this month')
      dates = []
      3.times do
        dates << "#{time.year}-#{time.month}-#{time.mday}"
        time += 10_080
      end
      dates.each do |date|
        FactoryGirl.create(:absence, student_id:Student.last.id, semester_id:Semester.last.id, date:date, required:30, justified:20, unexcused:0, late:5)
      end
      1.upto(6).each do |mark|
        FactoryGirl.create(:subject_template, name:mark)
        FactoryGirl.create(:subject, subject_template_id:SubjectTemplate.last.id, school_class_id:SchoolClass.last.id)
        FactoryGirl.create(:semestral_mark, student_id:Student.last.id, subject_id:Subject.last.id, mark:mark.to_s)
      end
      click_link "Raporty"
      save_and_open_page
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

    scenario "when there is not data" do
      click_link "Raporty"
      save_and_open_page
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
