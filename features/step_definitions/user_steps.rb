# coding: utf-8
Given /^I am logged in as a teacher$/ do
  FactoryGirl.create(:teacher)
  visit('/users/sign_in')
  fill_in('Login', :with => 'user1')
  fill_in('Hasło', :with => 'user_password')
  click_button('Zaloguj')
end
