# coding: utf-8
Given /^I am logged in as a teacher$/ do
  FactoryGirl.create(:teacher)
  visit('/users/sign_in')
  fill_in('Login', :with => 'teacher')
  fill_in('Hasło', :with => 'test')
  click_button('Zaloguj')
  assert page.has_content?("Zalogowano pomyślnie.")
end

Given /^I am logged in as a director$/ do
  visit('/users/sign_in')
  fill_in('Login', :with => 'director')
  fill_in('Hasło', :with => 'test')
  click_button('Zaloguj')
end

When /^I am logging in$/ do
  step "I am logged in as a teacher"
end

When /^I am logging out$/ do
  click_link("Wyloguj")
end
