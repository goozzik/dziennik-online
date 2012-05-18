require 'acceptance/acceptance_helper'

feature 'My first feature', %q{
  In order to ...
  As a ...
  I want ...
} do

  scenario 'first scenario' do
    true.should == true
  end

end
