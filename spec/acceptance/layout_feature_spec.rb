# coding: utf-8
require 'acceptance/acceptance_helper'

feature "layout" do
  before do
    FactoryGirl.create(:school)
    FactoryGirl.create(:semester, :school_id => School.last.id)
  end

  context "teacher" do
    before do
      FactoryGirl.create(:teacher)
      login "teacher"
    end

    scenario "navbar" do
      click_link "Konto"
      page.should have_xpath "//a[@href='/teacher/school_classes'][contains(text(), 'Ustawienia klas')]"
      page.should have_xpath "//a[@href='/users/edit'][contains(text(), 'Ustawienia konta')]"
      page.should have_xpath "//a[@href='/users/sign_out'][contains(text(), 'Wyloguj')]"
    end

  end

  context "student" do
    before do
      FactoryGirl.create(:teacher, :school_id => School.last.id)
      FactoryGirl.create(:school_class, :teacher_id => Teacher.last.id)
      FactoryGirl.create(:student, :school_class_id => SchoolClass.last.id)
      login "student"
    end

    scenario "navbar" do
      click_link "Konto"
      page.should have_xpath "//a[@href='/student/marks'][contains(text(), 'Oceny')]"
      page.should have_xpath "//a[@href='/student/absences'][contains(text(), 'Frekwencja')]"
      page.should have_xpath "//a[@href='/student/reports'][contains(text(), 'Raporty')]"
      page.should have_xpath "//a[@href='/student/messages'][contains(text(), 'Wiadomości')]"
      page.should have_xpath "//a[@href='/student/time_tables'][contains(text(), 'Plan lekcji')]"
      page.should have_xpath "//a[@href='#'][@class='dropdown-toggle']"  
      page.should have_xpath "//a[@href='/users/edit'][contains(text(), 'Ustawienia konta')]"
      page.should have_xpath "//a[@href='/users/sign_out'][contains(text(), 'Wyloguj')]"
    end

  end

  context "director" do
    before do
      FactoryGirl.create(:director, school_id:School.last.id)
      login "director"
    end

    scenario "navbar" do
      click_link "Konto"
      page.should have_xpath "//a[@href='/users/edit'][contains(text(), 'Ustawienia konta')]"
      page.should have_xpath "//a[@href='/users/sign_out'][contains(text(), 'Wyloguj')]"
    end

  end

  context "admin" do
    before do
      FactoryGirl.create(:admin)
      login "admin"
    end

    scenario "navbar" do
      click_link "Konto"
      page.should have_xpath "//a[@href='/users/edit'][contains(text(), 'Ustawienia konta')]"
      page.should have_xpath "//a[@href='/users/sign_out'][contains(text(), 'Wyloguj')]"
    end

  end

#  context "superadmin" do
#    before do
#      FactoryGirl.create(:superadmin)
#      login "superadmin"
#    end
#
#    scenario "navbar" do
#      click_link "Konto"
#      page.should have_xpath "//a[@href='/users/edit'][contains(text(), 'Ustawienia konta')]"
#      page.should have_xpath "//a[@href='/users/sign_out'][contains(text(), 'Wyloguj')]"
#    end
#
#  end

end
