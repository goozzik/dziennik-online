# coding: utf-8
require 'acceptance/acceptance_helper'

feature 'Director school classes' do

  context 'index' do
    before do
      school = FactoryGirl.create(:school)
      director = FactoryGirl.create(:director, :school_id => school.id)
      login('director')
    end

    scenario 'there is no active school class in school' do
      click_link "Klasy"
      page.should have_content "Szkoła nie posiada aktywnych klas."
    end

  end

end
