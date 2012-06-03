# coding: utf-8
require 'acceptance/acceptance_helper'

feature "Director absences" do

  context "index" do
    before do
      FactoryGirl.create(:school)
      FactoryGirl.create(:semester, :school_id => School.last.id)
      FactoryGirl.create(:director, :school_id => School.last.id)
      login('director')
    end

    scenario 'there is no active school class in school' do
      click_link "Klasy"
      assert_info_box "Szkoła nie ma aktywnych klas."
    end

  end

end
