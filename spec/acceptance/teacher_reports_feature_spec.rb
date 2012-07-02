# coding: utf-8
require 'acceptance/acceptance_helper'

feature 'Teacher reports' do

  context "index" do
    before do
      FactoryGirl.create(:school)
      FactoryGirl.create(:semester, school_id:School.last.id, semester:Time.now.month > 9 ? 1 : 2 )
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
      FactoryGirl.create(:school_class, teacher_id:Teacher.last.id)
      0.upto(5).each do |mark|
        FactoryGirl.create(:subject_template, name:mark)
        FactoryGirl.create(:subject, subject_template_id:SubjectTemplate.last.id, school_class_id:SchoolClass.last.id)
      end
      1.upto(3) do
        FactoryGirl.create(:student, school_class_id:SchoolClass.last.id)
        time = Chronic.parse('monday this month')
        dates = []
        3.times do
          dates << "#{time.year}-#{time.month}-#{time.mday}"
          time += 10_080
        end
        dates.each do |date|
          FactoryGirl.create(:absence, student_id:Student.last.id, semester_id:Semester.last.id, date:date, required:30, justified:20, unexcused:0, late:5)
        end
        0.upto(5).each do |mark|
          FactoryGirl.create(:semestral_mark, student_id:Student.last.id, subject_id:Subject.first.id + mark , mark:(mark + 1).to_s)
        end
      end
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
