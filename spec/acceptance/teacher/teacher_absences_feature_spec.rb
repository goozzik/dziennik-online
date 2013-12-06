# coding: utf-8
require 'acceptance/acceptance_helper'

feature 'Teacher absences feature' do

  describe "index" do
    let!(:school) { create(:school) }
    let!(:semester) { create(:semester, school: school) }
    let!(:teacher) { create(:teacher, school: school) }
    let!(:profile_template) { load_profile }
    let!(:school_class) { create(:school_class, profile: "Technik awionik",
                         teacher: teacher) }

    before { login "teacher" }

    scenario "info when school class have no students" do
      click_link "Frekwencja"
      assert_alert_box("Najpierw dodaj uczniów.")
    end

    scenario "info about how to add absences" do
      create(:student, school_class: school_class)
      click_link "Frekwencja"
      assert_info_box("Frekwencja")
    end

    context "month navigation" do
      let!(:student) { create(:student, school_class: school_class) }

      before { click_link "Frekwencja" }

      scenario "follow next month link" do
        next_month = Chronic.parse('monday next month')
        find(:xpath, "//a[@href='/teacher/absences?month=#{next_month.month}']").click
        page.should have_content "Frekwencja"
        page.should have_content "#{I18n.t(next_month.strftime("%B"))}"
      end

      scenario "follow previous month link" do
        previous_month = Chronic.parse('monday last month')
        find(:xpath, "//a[@href='/teacher/absences?month=#{previous_month.month}']").click
        page.should have_content "Frekwencja"
        page.should have_content "#{I18n.t(previous_month.strftime("%B"))}"
      end

      scenario "use select list and go to october" do
        create(:absence, student: student, month: 10, week: 1, required: 30, justified: 5)
        click_link "Październik"
        page.should have_xpath "//td[@class='absence 1 required_absence'][contains(text(), '30')]"
        page.should have_xpath "//td[@class='absence'][contains(text(), '5')]"
        page.should have_content "Październik"
      end

      scenario "use select list and go to april" do
        create(:absence, student_id: Student.last.id, month: 4, week: 1, required: 25, justified: 5)
        click_link "Kwiecień"
        page.should have_xpath "//td[@class='absence 1 required_absence'][contains(text(), '25')]"
        page.should have_xpath "//td[@class='absence'][contains(text(), '5')]"
        page.should have_content "Kwiecień"
      end
    end

    context "create", js: true do
      let!(:student) { create(:student, school_class: school_class) }

      before { click_link "Frekwencja" }

      scenario "ob" do
        reload_page
        element_id = student.id.to_s + "_1_required"
        page.execute_script("$('##{element_id}').trigger('click')")
        fill_in "absence_active", with: "33"
        sleep(1)
        find(:css, "#absence_active").native.send_key(:tab)
        reload_page
        page.should have_xpath "//td[@id='#{element_id}'][contains(text(), '33')]"
      end

    end

    context "update", js: true do
      let!(:student) { create(:student, school_class: school_class) }
      let!(:absence) { create(:absence, student: student, month: Time.now.month,
                              week: 1, semester: semester, required: 30) }

      scenario "ob" do
        date = Chronic.parse("monday this month").strftime("%Y-%m-%d")
        reload_page
        click_link "Frekwencja"
        element_id = student.id.to_s + "_1_required"
        page.execute_script("$('##{element_id}').trigger('click')")
        fill_in "absence_active", with: "20"
        sleep(1)
        find(:css, "#absence_active").native.send_key(:tab)
        reload_page
        page.should have_xpath "//td[@id='#{element_id}'][contains(text(), '20')]"
      end
    end

    context "update mass required", js: true do
      let!(:student) { create(:student, school_class: school_class) }

      scenario "when there is no previous 'required' fields filled" do
        reload_page
        click_link "Frekwencja"
        page.execute_script("$('#1').trigger('click')")
        fill_in "mass_required_active", :with => "28"
        sleep(1)
        find(:css, "#mass_required_active").native.send_key(:tab)
        element_id = student.id.to_s + "_1_required"
        page.should have_xpath "//td[@id='#{element_id}'][contains(text(), '28')]"
        reload_page
        page.should have_xpath "//td[@id='#{element_id}'][contains(text(), '28')]"
      end

      scenario "when there is 'required' field filled" do
        create(:absence, week: 1, month: Time.now.month,
               student: student, required: 25)
        reload_page
        click_link "Frekwencja"
        page.execute_script("$('#1').trigger('click')")
        fill_in "mass_required_active", with: "28"
        sleep(1)
        find(:css, "#mass_required_active").native.send_key(:tab)
        element_id = student.id.to_s + "_1_required"
        page.should have_xpath "//td[@id='#{element_id}'][contains(text(), '28')]"
        reload_page
        page.should have_xpath "//td[@id='#{element_id}'][contains(text(), '28')]"
      end
    end
  end

end
