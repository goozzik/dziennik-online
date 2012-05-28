# coding: utf-8

require 'acceptance/acceptance_helper'

feature 'Teacher subjects' do

  #context "index"
  context "show" do
    before do
      FactoryGirl.create(:teacher)
      FactoryGirl.create(:school_class, :teacher_id => Teacher.last.id)
      FactoryGirl.create(:student, :school_class_id => SchoolClass.last.id)
      FactoryGirl.create(:subject, :school_class_id => SchoolClass.last.id)
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

  end

end
