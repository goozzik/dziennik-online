# coding: utf-8
require 'acceptance/acceptance_helper'

feature "Director school classes" do

  context "index" do
    before do
      FactoryGirl.create(:school)
      FactoryGirl.create(:semester, :school_id => School.last.id)
      FactoryGirl.create(:director, :school_id => School.last.id)
      login('director')
    end

    scenario "there is no active school class in school" do
      click_link "Klasy"
      assert_info_box "Szkoła nie ma aktywnych klas."
    end

    scenario "when there is active school class in school" do
      FactoryGirl.create(:teacher, :school_id => School.last.id)
      FactoryGirl.create(:school_class, :teacher_id => Teacher.last.id)
      click_link "Klasy"
      page.should have_content "3 G Informatyk 2013"
    end

    context "follow 'Bieżąca frekwencja'" do
      before do
        FactoryGirl.create(:teacher, :school_id => School.last.id)
        FactoryGirl.create(:school_class, :teacher_id => Teacher.last.id)
        click_link "Klasy"
      end

      scenario "when there is no students" do
        click_link "Bieżąca frekwencja"
        assert_alert_box "Wychowawca klasy nie dodał jeszcze uczniów."
      end

      scenario "when there is student" do
        FactoryGirl.create(:student, :school_class_id => SchoolClass.last.id)
        click_link "Bieżąca frekwencja"
        page.should have_content "Frekwencja klasy 3 G"
      end

    end

    context "follow 'Bieżące Oceny'" do
      before do
        FactoryGirl.create(:teacher, :school_id => School.last.id)
        FactoryGirl.create(:school_class, :teacher_id => Teacher.last.id)
        click_link "Klasy"
      end

      context "when there is student" do
        before do
          FactoryGirl.create(:student, :school_class_id => SchoolClass.last.id)
        end

        scenario "and no subject" do
          click_link "Bieżące oceny"
          assert_alert_box "Wychowawca klasy nie dodał jeszcze przedmiotów."
        end

        scenario "and subject" do
          FactoryGirl.create(:subject_template)
          FactoryGirl.create(:subject, subject_template_id:SubjectTemplate.last.id, :school_class_id => SchoolClass.last.id)
          click_link "Bieżące oceny"
          page.should have_content "Oceny klasy 3 G"
        end

      end

      scenario "when there is no students" do
        click_link "Bieżące oceny"
        assert_alert_box "Wychowawca klasy nie dodał jeszcze uczniów."
      end

    end

  end

end
