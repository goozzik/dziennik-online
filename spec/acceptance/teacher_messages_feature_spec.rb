# coding: utf-8
require 'acceptance/acceptance_helper'

feature 'Teacher messages' do

  context "index" do
    before do
      FactoryGirl.create(:school)
      FactoryGirl.create(:semester, :school_id => School.last.id)
      FactoryGirl.create(:teacher, :school_id => School.last.id)
      FactoryGirl.create(:school_class, :teacher_id => Teacher.last.id)
      login('teacher')
    end

    scenario "when there is message" do
      FactoryGirl.create(:message, :school_class_id => SchoolClass.last.id)
      click_link "Wiadomości"
      page.should have_content "Witam"
      page.should have_content "Przykładowa wiadomość"
    end

    scenario "there are no messages for class" do
      click_link "Wiadomości"
      page.should have_content "Ta klasa nie ma wiadomośći!"
    end

  end

  context "create" do
    before do
      FactoryGirl.create(:school)
      FactoryGirl.create(:semester, :school_id => School.last.id)
      FactoryGirl.create(:teacher, :school_id => School.last.id)
      FactoryGirl.create(:school_class, :teacher_id => Teacher.last.id)
      login('teacher')
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
    before do
      FactoryGirl.create(:school)
      FactoryGirl.create(:semester, :school_id => School.last.id)
      FactoryGirl.create(:teacher, :school_id => School.last.id)
      FactoryGirl.create(:school_class, :teacher_id => Teacher.last.id)
      login('teacher')
      FactoryGirl.create(:message, :school_class_id => SchoolClass.last.id)
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
    before do
      FactoryGirl.create(:school)
      FactoryGirl.create(:semester, :school_id => School.last.id)
      FactoryGirl.create(:teacher, :school_id => School.last.id)
      FactoryGirl.create(:school_class, :teacher_id => Teacher.last.id)
      FactoryGirl.create(:message, :school_class_id => SchoolClass.last.id)
      login('teacher')
    end

    scenario "when there are two messages" do
      FactoryGirl.create(:message, :title => "Witam!", :school_class_id => SchoolClass.last.id)
      click_link "Wiadomości"
      click_link "Usuń"
      assert Message.count == 1
    end

    scenario "when there is one message" do
      click_link "Wiadomości"
      click_link "Usuń"
      page.should have_content "Ta klasa nie ma wiadomośći!"
    end

  end

end
