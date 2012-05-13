# coding: utf-8
Given /^I am logged in as a teacher$/ do
  visit('/users/sign_in')
  fill_in('Login', :with => 'teacher')
  fill_in('Hasło', :with => 'test')
  click_button('Zaloguj')
end

Given /^I am logged in as a director$/ do
  visit('/users/sign_in')
  fill_in('Login', :with => 'director')
  fill_in('Hasło', :with => 'test')
  click_button('Zaloguj')
end

Given /^I am logged in as a student$/ do
  visit('/users/sign_in')
  fill_in('Login', :with => 'student')
  fill_in('Hasło', :with => 'test')
  click_button('Zaloguj')
end

When /^I am logging in$/ do
  step "I am logged in as a teacher"
end

When /^I am logging out$/ do
  click_link("Wyloguj")
end
