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

  end

end
