# coding: utf-8

module LoginHelpers

  def login(acc_type)
    visit root_path
    #page.should have_content "Zaloguj się"
    fill_in "user_username", :with => acc_type
    fill_in "user_password", :with => "test"
    click_button "Zaloguj"
    page.should have_content "Zalogowano pomyślnie."
  end

end

RSpec.configuration.include LoginHelpers, :type => :acceptance
