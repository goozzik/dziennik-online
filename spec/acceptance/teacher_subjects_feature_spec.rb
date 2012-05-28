# coding: utf-8

require 'acceptance/acceptance_helper'

feature 'Teacher subjects' do

  #context "index"
  context "show" do
    before do
      FactoryGirl.create(:school)
      FactoryGirl.create(:teacher, :school_id => School.last.id)
      FactoryGirl.create(:school_class, :teacher_id => Teacher.last.id)
      FactoryGirl.create(:student, :school_class_id => SchoolClass.last.id)
      FactoryGirl.create(:subject_template)
      FactoryGirl.create(:subject, :subject_template_id => SubjectTemplate.last.id, :school_class_id => SchoolClass.last.id)
      login "teacher"
      click_link "Oceny"
    end

    scenario "description popover", :js => true do
      FactoryGirl.create(:description, :subject_id => Subject.last.id)
      click_link "Pokaż oceny"
      page.execute_script('$(".description").trigger("mouseover")')
      page.should have_xpath "//div[@class='popover fade right in']"
      page.should have_content "Kartkówka"
      page.should have_content "Kwadraty"
    end

    scenario "description plus button popover info", :js => true do
      click_link "Pokaż oceny"
      page.execute_script('$("#add_description").trigger("mouseover")')
      page.should have_xpath "//div[@class='popover fade right in']"
      page.should have_content "Dodaj nowy typ oceny"
      page.should have_content "Kliknij aby dodać nową ocenę dla klasy."
    end

  end

end
