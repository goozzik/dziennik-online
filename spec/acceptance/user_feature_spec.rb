#coding: utf-8

require 'acceptance/acceptance_helper'

feature 'User' do

  context "update" do
    before do
      user = FactoryGirl.create(:teacher)
      login('teacher')
      click_link "Konto"
      click_link "Ustawienia konta"
    end

    scenario "password" do
      fill_in 'user_password', :with => 'test123'
      fill_in 'user_password_confirmation', :with => 'test123'
      fill_in 'user_current_password', :with => 'test'
      click_button 'Zapisz'
      page.should have_content "Konto zostało pomyślnie zaktualizowane."
    end

    scenario "email" do
      fill_in 'user_email', :with => 'user@example.com'
      fill_in 'user_current_password', :with => 'test'
      click_button 'Zapisz'
      page.should have_content "Konto zostało pomyślnie zaktualizowane."
    end

  end

end
