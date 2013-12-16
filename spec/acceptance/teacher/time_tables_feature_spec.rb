# coding: utf-8

require 'acceptance/acceptance_helper'

feature 'time tables' do

  let!(:school) { create(:school) }
  let!(:semester) { create(:semester, school: school) }
  let!(:teacher) { create(:teacher, school: school) }
  let!(:profile) { load_profile }
  let!(:school_class) { create(:school_class, teacher: teacher) }

  context "index" do
    before do
      login "teacher"
    end

    scenario "when there is no time tables" do
      click_link "Plan lekcji"
      assert_info_box "Klasa nie ma planu lekcji."
    end

    context "create" do
      scenario "with valid attributes" do
        click_link "Plan lekcji"
        select "Wtorek", :from => "time_table_week_day"
        select "0", :from => "time_table_lessons_attributes_0_subject_id"
        click_button "Zapisz"
        page.should have_xpath("//th[contains(text(), Wtorek)]")
        page.should have_xpath("//td[contains(text(), Matematyka)]")
      end
    end

    context "delete" do
      let!(:time_table) { create(:time_table, school_class: school_class) }
      let!(:lesson) { create(:lesson, time_table: time_table,
                             subject: Subject.last, number: 0) }

      scenario "when there is one time table" do
        click_link "Plan lekcji"
        click_link "Usuń"
        page.should_not have_xpath("//th[contains(text(), Poniedziałek)]")
        page.should_not have_xpath("//td[contains(text(), Matematyka)]")
      end

      scenario "when there are two time tables" do
        create(:time_table, school_class: school_class, week_day: 3)
        create(:lesson, time_table: time_table, subject: Subject.last,
               number: 0)
        click_link "Plan lekcji"
        click_link "Usuń"
        page.should_not have_content "Klasa nie ma planu lekcji."
      end
    end
  end

end
