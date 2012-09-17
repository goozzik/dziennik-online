# coding: utf-8
require 'acceptance/acceptance_helper'

feature 'Teacher absences feature' do

  context "index" do
    before do
      FactoryGirl.create(:school)
      load_subject_templates
      load_semester
      FactoryGirl.create(:teacher, school_id: School.last.id)
      login "teacher"
    end

    scenario "info when school class is not set" do
      click_link "Frekwencja"
      assert_alert_box("Najpierw dodaj klasę.")
    end

    scenario "info when school class have no students" do
      FactoryGirl.create(:school_class, teacher_id: Teacher.last.id)
      reload_page
      click_link "Frekwencja"
      assert_alert_box("Najpierw dodaj uczniów.")
    end

    scenario "info about how to add absences" do
      FactoryGirl.create(:school_class, teacher_id: Teacher.last.id)
      FactoryGirl.create(:student, school_class_id: SchoolClass.last.id)
      reload_page
      click_link "Frekwencja"
      assert_info_box("Frekwencja")
    end

    context "month navigation" do
      before do
        FactoryGirl.create(:school_class, teacher_id: Teacher.last.id)
        FactoryGirl.create(:student, school_class_id: SchoolClass.last.id)
        reload_page
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

      scenario "use select list and go to october" do
        date = Chronic.parse('monday this month', now: Time.local(Semester.last.start_year, 10))
        FactoryGirl.create(:absence, student_id: Student.last.id, date: date, required: 30, justified: 5)
        click_link "Październik"
        save_and_open_page
        page.should have_xpath "//td[@class='absence #{date.strftime("%Y-%m-%d")}_required'][contains(text(), '30')]"
        page.should have_xpath "//td[@class='absence'][contains(text(), '5')]"
        page.should have_content "Październik #{date.year}"
      end

      scenario "use select list and go to april" do
        date = Chronic.parse('monday this month', now: Time.local(Semester.last.end_year, 4))
        FactoryGirl.create(:absence, student_id: Student.last.id, date: date, required: 25, justified: 5)
        click_link "Kwiecień"
        page.should have_xpath "//td[@class='absence #{date.strftime("%Y-%m-%d")}_required'][contains(text(), '25')]"
        page.should have_xpath "//td[@class='absence'][contains(text(), '5')]"
        page.should have_content "Kwiecień #{date.year}"
      end

    end

    context "create", :js => true do
      before do
        FactoryGirl.create(:school_class, :teacher_id => Teacher.last.id)
        FactoryGirl.create(:student, :school_class_id => SchoolClass.last.id)
        click_link "Frekwencja"
      end

      scenario "ob" do
        reload_page
        date = Chronic.parse("monday this month", :now => Time.now).strftime("%Y-%m-%d")
        element_id = Student.last.id.to_s + "_" + date + "_required"
        page.execute_script("$('##{element_id}').trigger('click')")
        fill_in "absence_active", :with => "33"
        sleep(1)
        find(:css, "#absence_active").native.send_key(:tab)
        reload_page
        page.should have_xpath "//td[@class='absence #{date}_required'][contains(text(), '33')]"
      end

    end

    context "update", :js => true do
      before do
        FactoryGirl.create(:school_class, :teacher_id => Teacher.last.id)
        FactoryGirl.create(:student, :school_class_id => SchoolClass.last.id)
        @date = Chronic.parse("monday this month", :now => Time.now).strftime("%Y-%m-%d")
        FactoryGirl.create(:absence, :student_id => Student.last.id, :semester_id => Semester.last.id, :date => @date, :required => 30)
        reload_page
        click_link "Frekwencja"
      end

      scenario "ob" do
        element_id = Student.last.id.to_s + "_" + @date + "_required"
        page.execute_script("$('##{element_id}').trigger('click')")
        fill_in "absence_active", :with => "20"
        sleep(1)
        find(:css, "#absence_active").native.send_key(:tab)
        reload_page
        page.should have_xpath "//td[@class='absence #{@date}_required'][contains(text(), '20')]"
      end

    end

    context "update mass required", :js => true do
      before do
        FactoryGirl.create(:school_class, :teacher_id => Teacher.last.id)
        FactoryGirl.create(:student, :school_class_id => SchoolClass.last.id)
      end

      scenario "when there is no previous 'required' fields filled" do
        reload_page
        click_link "Frekwencja"
        date = Chronic.parse('monday this month').strftime('%Y-%m-%d')
        page.execute_script("$('##{date}').trigger('click')")
        fill_in "mass_required_active", :with => "28"
        sleep(1)
        find(:css, "#mass_required_active").native.send_key(:tab)
        page.should have_xpath "//td[@class='absence #{date}_required'][contains(text(), '28')]"
        reload_page
        page.should have_xpath "//td[@class='absence #{date}_required'][contains(text(), '28')]"
      end

      scenario "when there is 'required' field filled" do
        date = Chronic.parse('monday this month').strftime('%Y-%m-%d')
        FactoryGirl.create(:absence, date: date, student_id: Student.last.id, required: 25)
        reload_page
        click_link "Frekwencja"
        page.execute_script("$('##{date}').trigger('click')")
        fill_in "mass_required_active", :with => "28"
        sleep(1)
        find(:css, "#mass_required_active").native.send_key(:tab)
        page.should have_xpath "//td[@class='absence #{date}_required'][contains(text(), '28')]"
        reload_page
        page.should have_xpath "//td[@class='absence #{date}_required'][contains(text(), '28')]"
      end

    end

  end

end
