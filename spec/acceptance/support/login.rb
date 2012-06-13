# coding: utf-8

module LoginHelpers

  def login(acc_type)
    visit root_path
    #page.should have_content "Zaloguj się"
    user = case acc_type
      when "student"
        Student.last
      when "teacher"
        Teacher.last
      when "admin"
        Admin.last
      when "director"
        Director.last
    end
    fill_in "user_username", :with => user.username
    fill_in "user_password", :with => user.username
    click_button "Zaloguj"
    page.should have_content "Zalogowano pomyślnie."
  end

end

RSpec.configuration.include LoginHelpers, :type => :acceptance
