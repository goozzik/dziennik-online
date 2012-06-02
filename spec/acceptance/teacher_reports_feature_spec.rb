# coding: utf-8
require 'acceptance/acceptance_helper'

feature 'Teacher reports' do

  context "index" do
    before do
      FactoryGirl.create(:school)
      FactoryGirl.create(:semester, :school_id => School.last.id)
      FactoryGirl.create(:teacher, :school_id => School.last.id)
      login('teacher')
    end

    scenario "info when school class is not set" do
      click_link "Uczniowie"
      assert_alert_box("Najpierw dodaj klasę!")
    end

    scenario "info when school class have no students" do
      FactoryGirl.create(:school_class, :teacher_id => Teacher.last.id)
      click_link "Uczniowie"
      assert_info_box("Klasa nie ma uczniów.")
    end

  end

end
