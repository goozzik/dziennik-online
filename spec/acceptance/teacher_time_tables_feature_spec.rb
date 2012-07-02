# coding: utf-8

require 'acceptance/acceptance_helper'

feature 'Teacher time tables' do

  context "index" do
    before do
      FactoryGirl.create(:school)
      FactoryGirl.create(:semester, :school_id => School.last.id)
      FactoryGirl.create(:teacher, :school_id => School.last.id)
      login "teacher"
    end

    scenario "info when school class is not set" do
      click_link "Dokumenty"
      assert_alert_box("Najpierw dodaj klasę.")
    end

    scenario "when there is no subjects for school class" do
      FactoryGirl.create(:school_class, :teacher_id => Teacher.last.id)
      click_link "Plan lekcji"
      assert_alert_box "Najpierw dodaj przedmioty."
    end

    scenario "when there is no time tables" do
      FactoryGirl.create(:school_class, :teacher_id => Teacher.last.id)
      FactoryGirl.create(:subject_template)
      FactoryGirl.create(:subject, :subject_template_id => SubjectTemplate.last.id, :school_class_id => SchoolClass.last.id)
      click_link "Plan lekcji"
      assert_info_box "Klasa nie ma planu lekcji."
    end

    scenario "when there is time table" do
      FactoryGirl.create(:school_class, :teacher_id => Teacher.last.id)
      FactoryGirl.create(:subject_template)
      FactoryGirl.create(:subject, :subject_template_id => SubjectTemplate.last.id, :school_class_id => SchoolClass.last.id)
      FactoryGirl.create(:time_table, :school_class_id => SchoolClass.last.id)
      FactoryGirl.create(:lesson, :time_table_id => TimeTable.last.id, :subject_id => Subject.last.id, :number => 0)
      click_link "Plan lekcji"
    end

    context "create" do
      before do
        FactoryGirl.create(:school_class, :teacher_id => Teacher.last.id)
        FactoryGirl.create(:subject_template)
        FactoryGirl.create(:subject, :subject_template_id => SubjectTemplate.last.id, :school_class_id => SchoolClass.last.id)
      end

      scenario "with valid attributes" do
        click_link "Plan lekcji"
        select "Wtorek", :from => "time_table_week_day"
        select "Matematyka", :from => "time_table_lessons_attributes_0_subject_id"
        click_button "Zapisz"
        page.should have_xpath("//th[contains(text(), Wtorek)]")
        page.should have_xpath("//td[contains(text(), Matematyka)]")
      end

#      TODO story #176
#      scenario "with empty week day attribute" do
#        click_button "Zapisz"
#        click_link "Plan lekcji"
#      end

    end

    context "delete" do
      before do
        FactoryGirl.create(:school_class, :teacher_id => Teacher.last.id)
        FactoryGirl.create(:subject_template)
        FactoryGirl.create(:subject, :subject_template_id => SubjectTemplate.last.id, :school_class_id => SchoolClass.last.id)
        FactoryGirl.create(:time_table, :school_class_id => SchoolClass.last.id)
        FactoryGirl.create(:lesson, :time_table_id => TimeTable.last.id, :subject_id => Subject.last.id, :number => 0)
      end

      scenario "when there is one time table" do
        click_link "Plan lekcji"
        click_link "Usuń"
        page.should_not have_xpath("//th[contains(text(), Poniedziałek)]")
        page.should_not have_xpath("//td[contains(text(), Matematyka)]")
      end

      scenario "when there are two time tables" do
        FactoryGirl.create(:time_table, :school_class_id => SchoolClass.last.id, :week_day => 3)
        FactoryGirl.create(:lesson, :time_table_id => TimeTable.last.id, :subject_id => Subject.last.id, :number => 0)
        click_link "Plan lekcji"
        click_link "Usuń"
        page.should_not have_content "Klasa nie ma planu lekcji."
      end

    end

  end

end
