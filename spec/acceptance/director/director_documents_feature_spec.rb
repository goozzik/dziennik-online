# coding: utf-8
require "acceptance/acceptance_helper"

feature "documents" do

  context "index" do
    let!(:school) { create(:school) }
    let!(:director) { create(:director, school: school) }
    before do
      login "director"
    end

    scenario "when there is no documents for school" do
      click_link "Dokumenty"
      assert_info_box "Szkoła nie ma dokumentów."
    end

    scenario "when there is document for school" do
      create(:document, for_teachers: "1", user: director, user_type: "User")
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
