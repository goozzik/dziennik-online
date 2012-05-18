#coding: utf-8

require 'acceptance/acceptance_helper'

feature 'User' do

  context "edit" do
    before do
      user = FactoryGirl.create(:teacher)
      login
      click_link "Ustawienia"
    end

    scenario "Change password" do
      fill_in 'user_password', :with => 'test123'
      fill_in 'user_password_confirmation', :with => 'test123'
      fill_in 'user_current_password', :with => 'test'
      click_button 'Zapisz'
      assert page.has_content?("Konto zostało pomyślnie zaktualizowane.")
    end

    scenario "Change email" do
      fill_in 'user_email', :with => 'user@example.com'
      fill_in 'user_current_password', :with => 'test'
      click_button 'Zapisz'
      assert page.has_content?("Konto zostało pomyślnie zaktualizowane.")
    end

  end

end
