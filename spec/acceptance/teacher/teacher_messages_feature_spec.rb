# coding: utf-8
require 'acceptance/acceptance_helper'

feature 'messages' do

  let!(:school) { create(:school) }
  let!(:semester) { create(:semester, school: school) }
  let!(:teacher) { create(:teacher, school: school) }
  let!(:profile) { load_profile }
  let!(:school_class) { create(:school_class, profile: "Technik awionik",
                               teacher: teacher) }

  before do
    login('teacher')
  end

  context "index" do
    scenario "when there is message" do
      create(:message, school_class: school_class)
      click_link "Wiadomości"
      page.should have_content "Witam"
      page.should have_content "Przykładowa wiadomość"
    end

    scenario "there are no messages for class" do
      click_link "Wiadomości"
      assert_info_box "Klasa nie ma wiadomośći."
    end
  end

  context "create" do
    before do
      click_link "Wiadomości"
    end

    scenario "validate presence of title" do
      click_button "Zapisz"
      page.should have_content "nie może być puste"
    end

    scenario "validate presence of body" do
      fill_in "message_title", :with => "Witam"
      click_button "Zapisz"
      page.should have_content "nie może być puste"
    end

    scenario "with valid params" do
      fill_in "message_title", :with => "Witam"
      fill_in "message_body", :with => "Przykładowa wiadomość"
      click_button "Zapisz"
      page.should have_content "Witam"
      page.should have_content "Przykładowa wiadomość"
    end
  end

  context "update" do
    let!(:message) { create(:message, school_class: school_class) }

    before do
      click_link "Wiadomości"
      click_link "Edytuj"
    end

    scenario "validate presence of title" do
      fill_in "message_title", :with => ""
      click_button "Zapisz"
      page.should have_content "nie może być puste"
    end

    scenario "validate presence of body" do
      fill_in "message_body", :with => ""
      click_button "Zapisz"
      page.should have_content "nie może być puste"
    end
  end

  context "destroy" do
    let!(:message) { create(:message, school_class: school_class) }

    scenario "when there are two messages" do
      create(:message, title: "Witam!", school_class: school_class)
      click_link "Wiadomości"
      click_link "Usuń"
      assert Message.count == 1
    end

    scenario "when there is one message" do
      click_link "Wiadomości"
      click_link "Usuń"
      assert_info_box "Klasa nie ma wiadomośći."
    end
  end

end
