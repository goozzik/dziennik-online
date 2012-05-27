# coding: utf-8

require 'acceptance/acceptance_helper'

feature 'Teacher time tables' do

  context "index" do
    before do
      school = FactoryGirl.create(:school)
      teacher = FactoryGirl.create(:teacher, :school_id => school.id)
      school_class = FactoryGirl.create(:school_class, :teacher_id => teacher.id)
      login "teacher"
    end

    scenario "There is no subjects for school class" do
      click_link "Plan lekcji"
      page.should have_content "Najpierw dodaj przedmioty."
    end

  end

end
