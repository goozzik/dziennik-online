# coding: utf-8
require "acceptance/acceptance_helper"

feature "Director documents" do

  context "index" do
    before do
      FactoryGirl.create(:school)
      FactoryGirl.create(:director, :school_id => School.last.id)
      login "director" 
    end

    scenario "when there is no documents for school" do
      click_link "Dokumenty"
      assert_info_box "Szkoła nie ma dokumentów."
    end

    scenario "when there is document for school" do
      FactoryGirl.create(:document, for_teachers:"1", user_id:Director.last.id, user_type:"User")
      click_link "Dokumenty"
      page.should have_content "test_dokument"
      page.should have_content "testowy dokument"
    end

    context "create" do
      before do 
        click_link "Dokumenty"
      end

      scenario "with valid attributes" do
        fill_in "document_name", with: "test_dokument"
        fill_in "document_description", with: "testowy dokument"
        attach_file "document_document", "#{Rails.root}/test/fixtures/files/trollface.jpeg" 
        save_and_open_page
        click_button "Zapisz"
        page.should have_content "test_dokument"
        page.should have_content "testowy dokument"
      end

    end

    context "download" do
      #
    end

  end

end
