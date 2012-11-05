# coding: utf-8
require 'acceptance/acceptance_helper'

feature 'Teacher documents feature' do

  context "index" do
    before do
      FactoryGirl.create(:school)
      load_semester
      load_subject_templates
      FactoryGirl.create(:teacher, school_id: School.last.id)
      FactoryGirl.create(:school_class, profile: "Technik awionik", teacher_id: Teacher.last.id)
      login "teacher"
    end

    scenario "when there is no documents" do
      click_link "Dokumenty"
      assert_info_box "Klasa nie ma dokumentów."
    end

    scenario "when there is document" do
      FactoryGirl.create(:document, for_teachers:"0", user_id:Teacher.last.id, user_type:"User")
      click_link "Dokumenty"
      page.should have_content "test_dokument"
      page.should have_content "testowy dokument"
    end

    scenario "when there is document for teachers" do
      FactoryGirl.create(:document, for_teachers:"1", user_id:Teacher.last.id, user_type:"User")
      click_link "Dokumenty"
      page.should have_content "test_dokument"
      page.should have_content "testowy dokument"
    end

    context "create" do

      scenario "for teachers in school" do
        FactoryGirl.create(:school_class, teacher_id: Teacher.last.id)
        click_link "Dokumenty"
      end

    end

    context "download" do
      #
    end


  end

end
