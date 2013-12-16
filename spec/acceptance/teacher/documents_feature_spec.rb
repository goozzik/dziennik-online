# coding: utf-8
require 'acceptance/acceptance_helper'

feature 'documents' do

  let!(:school) { create(:school) }
  let!(:semester) { create(:semester, school: school) }
  let!(:profile) { load_profile }
  let!(:teacher) { create(:teacher, school: school) }
  let!(:school_class) { create(:school_class, profile: "Technik awionik",
                               teacher: teacher) }

  context "index" do
    before do
      login "teacher"
    end

    scenario "when there is no documents" do
      click_link "Dokumenty"
      assert_info_box "Klasa nie ma dokumentów."
    end

    scenario "when there is document" do
      create(:document, for_teachers:"0", user: teacher, user_type: "User")
      click_link "Dokumenty"
      page.should have_content "test_dokument"
      page.should have_content "testowy dokument"
    end

    scenario "when there is document for teachers" do
      create(:document, for_teachers: "1", user: teacher, user_type:"User")
      click_link "Dokumenty"
      page.should have_content "test_dokument"
      page.should have_content "testowy dokument"
    end

    context "create" do
      scenario "for teachers in school" do
        create(:school_class, teacher: teacher)
        click_link "Dokumenty"
      end
    end

    context "download" do
      #
    end
  end

end
