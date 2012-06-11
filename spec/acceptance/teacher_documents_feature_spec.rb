# coding: utf-8
require 'acceptance/acceptance_helper'

feature 'Teacher documents feature' do

  context "index" do
    before do
      FactoryGirl.create(:school)
      FactoryGirl.create(:semester, :school_id => School.last.id)
      FactoryGirl.create(:teacher, :school_id => School.last.id)
      login "teacher"
    end

    scenario "info when school class is not set" do
      click_link "Dokumenty"
      assert_alert_box("Najpierw dodaj klasę!")
    end

    scenario "when there is no documents" do
      FactoryGirl.create(:school_class, :teacher_id => Teacher.last.id)
      click_link "Dokumenty"
      assert_info_box "Klasa nie ma dokumentów."
    end

    scenario "when there is document" do
      FactoryGirl.create(:school_class, :teacher_id => Teacher.last.id)
      FactoryGirl.create(:document, document:"dokument.doc", for_teachers:"0", user_id:Teacher.last.id, user_type:"User")
      click_link "Dokumenty"
      page.should have_content "test_dokument"
      page.should have_content "testowy dokument"
    end

    scenario "when there is document for teachers" do
      FactoryGirl.create(:school_class, :teacher_id => Teacher.last.id)
      FactoryGirl.create(:document, document:"dokument.doc", for_teachers:"1", user_id:Teacher.last.id)
      click_link "Dokumenty"
      page.should have_content "test_dokument"
      page.should have_content "testowy dokument"
    end

    context "create" do

      scenario "for teachers in school" do
        FactoryGirl.create(:school_class, :teacher_id => Teacher.last.id)
        click_link "Dokumenty"
      end

    end

    context "download" do
      #
    end


  end

end
