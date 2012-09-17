# coding: utf-8

require "acceptance/acceptance_helper"

feature "Student time tables" do

  context "index" do
    before do
      FactoryGirl.create(:school)
      FactoryGirl.create(:semester, school_id:School.last.id)
      FactoryGirl.create(:teacher, school_id:School.last.id)
      load_subject_templates
      FactoryGirl.create(:school_class, profile:"Technik awionik", teacher_id:Teacher.last.id)
      FactoryGirl.create(:student, school_class_id:SchoolClass.last.id)
      login "student"
    end

    scenario "when there is no time tables" do
      click_link "Plan lekcji"
      assert_info_box "Wychowawca nie uzupełnił jeszcze planu lekcji."
    end

    scenario "when there is time table" do
      FactoryGirl.create(:time_table, school_class_id: SchoolClass.last.id)
      FactoryGirl.create(:lesson, time_table_id: TimeTable.last.id, subject_id: Subject.last.id, number: 0)
      click_link "Plan lekcji"
      page.should have_content "Poniedziałek"
      page.should have_content "5"
    end

  end

end
