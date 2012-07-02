# coding: utf-8
require 'acceptance/acceptance_helper'

feature 'Teacher absences feature' do

  context "index" do
    before do
      FactoryGirl.create(:school)
      FactoryGirl.create(:semester, :school_id => School.last.id)
      FactoryGirl.create(:teacher, :school_id => School.last.id)
      login "teacher"
    end

    scenario "info when school class is not set" do
      click_link "Frekwencja"
      assert_alert_box("Najpierw dodaj klasę.")
    end

    scenario "info when school class have no students" do
      FactoryGirl.create(:school_class, :teacher_id => Teacher.last.id)
      click_link "Frekwencja"
      assert_alert_box("Najpierw dodaj uczniów.")
    end

    scenario "info about how to add absences" do
      FactoryGirl.create(:school_class, :teacher_id => Teacher.last.id)
      FactoryGirl.create(:student, :school_class_id => SchoolClass.last.id)
      click_link "Frekwencja"
      save_and_open_page
      assert_info_box("Frekwencja")
    end

    context "month navigation" do
      before do
        FactoryGirl.create(:school_class, :teacher_id => Teacher.last.id)
        FactoryGirl.create(:student, :school_class_id => SchoolClass.last.id)
        click_link "Frekwencja"
      end

      scenario "follow next month link" do
        month = Chronic.parse('monday this month')
        next_month = Chronic.parse('monday next month', :now => month)
        find(:xpath, "//a[@href='/teacher/absences?date=#{next_month.strftime("%Y-%m-%d")}']").click
        page.should have_content "Frekwencja"
        page.should have_content "#{I18n.t(next_month.strftime("%B"))} #{next_month.year}"
      end

      scenario "follow previous month link" do
        month = Chronic.parse('monday this month')
        previous_month = Chronic.parse('monday last month', :now => month)
        find(:xpath, "//a[@href='/teacher/absences?date=#{previous_month.strftime("%Y-%m-%d")}']").click
        page.should have_content "Frekwencja"
        page.should have_content "#{I18n.t(previous_month.strftime("%B"))} #{previous_month.year}"
      end
    end

    context "create", :js => true do
      before do
        FactoryGirl.create(:school_class, :teacher_id => Teacher.last.id)
        FactoryGirl.create(:student, :school_class_id => SchoolClass.last.id)
        click_link "Frekwencja"
      end

      scenario "ob" do
        date = Chronic.parse("monday this month", :now => Time.now).strftime("%Y-%m-%d")
        element_id = Student.last.id.to_s + "_" + date + "_required"
        page.execute_script("$('##{element_id}').trigger('click')")
        fill_in "absence_active", :with => "33"
        sleep(1)
        find(:css, "#absence_active").native.send_key(:tab)
        reload_page
        page.should have_xpath "//td[@class='absence'][contains(text(), '33')]"
      end

    end

    context "update", :js => true do
      before do
        FactoryGirl.create(:school_class, :teacher_id => Teacher.last.id)
        FactoryGirl.create(:student, :school_class_id => SchoolClass.last.id)
        @date = Chronic.parse("monday this month", :now => Time.now).strftime("%Y-%m-%d")
        FactoryGirl.create(:absence, :student_id => Student.last.id, :semester_id => Semester.last.id, :date => @date, :required => 30)
        click_link "Frekwencja"
      end

      scenario "ob" do
        element_id = Student.last.id.to_s + "_" + @date + "_required"
        page.execute_script("$('##{element_id}').trigger('click')")
        fill_in "absence_active", :with => "20"
        sleep(1)
        find(:css, "#absence_active").native.send_key(:tab)
        reload_page
        page.should have_xpath "//td[@class='absence'][contains(text(), '20')]"
      end

    end

  end

end
