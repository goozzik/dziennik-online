# coding: utf-8

require 'acceptance/acceptance_helper'

feature 'Teacher students' do

  context 'show' do
    before do
      school = FactoryGirl.create(:school)
      teacher = FactoryGirl.create(:teacher, :school_id => school.id)
      school_class = FactoryGirl.create(:school_class, :teacher_id => teacher.id)
      student = FactoryGirl.create(:student, :school_class_id => SchoolClass.last.id)
      login
      click_link "Uczniowie"
    end

    scenario 'All user information' do
      click_link "Więcej"
      assert page.has_content? "student"
      assert page.has_content? "Jacek"
      assert page.has_content? "Placek"
      assert page.has_content? '93052334123'
      assert page.has_content? '1'
      assert page.has_content? 'Słowackiego 3/3'
      assert page.has_content? 'Częstochowa'
      assert page.has_content? '42-200'
      assert page.has_content? 'Ślaskie'
      assert page.has_content? '34233123'
    end

  end

end
