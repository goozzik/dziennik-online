# coding: utf-8
require 'acceptance/acceptance_helper'

feature "Admin semesters" do

  background do
    time_now = Time.parse("Feb 24 2013")
    Time.stub!(:now).and_return(time_now)
    @school = FactoryGirl.create(:school)
    FactoryGirl.create(:admin, school_id:@school.id)
    @teacher = FactoryGirl.create(:teacher, :school_id => @school.id)
    FactoryGirl.create(:semester, school_id:@school.id, semester:2, start_year:2012, end_year:2013)
    FactoryGirl.create(:profile_template, school_id: @school.id)
    login "admin"
    click_link "Ustawienia szkoły"
  end

  scenario "it should update 1st grade school classes to 2nd when new year come" do
    school_class = FactoryGirl.create(:school_class, yearbook:2016, :teacher_id => @teacher.id)
    fill_in "semester_start_year", with: "2013"
    fill_in "semester_end_year", with: "2014"
    select "1", from: "semester_semester"
    click_button "Zapisz"
    school_class.grade.should == 1
    new_school_year_time = Time.parse("Sep 5 2013")
    Time.stub!(:now).and_return(new_school_year_time)
    find(:xpath, "//a[contains(text(), 'Ustaw jako aktywny')][1]").click
    SchoolClass.find(school_class.id).grade.should == 2
  end

  scenario "it should update 2nd grade school classes to 3rd when new year come" do
    school_class = FactoryGirl.create(:school_class, yearbook:2015, :teacher_id => @teacher.id)
    fill_in "semester_start_year", with: "2013"
    fill_in "semester_end_year", with: "2014"
    select "1", from: "semester_semester"
    click_button "Zapisz"
    school_class.grade.should == 2
    new_school_year_time = Time.parse("Sep 5 2013")
    Time.stub!(:now).and_return(new_school_year_time)
    find(:xpath, "//a[contains(text(), 'Ustaw jako aktywny')][1]").click
    SchoolClass.find(school_class.id).grade.should == 3
  end

  scenario "it should update 3rd grade school classes to 4th when new year come" do
    school_class = FactoryGirl.create(:school_class, yearbook:2014, :teacher_id => @teacher.id)
    fill_in "semester_start_year", with: "2013"
    fill_in "semester_end_year", with: "2014"
    select "1", from: "semester_semester"
    click_button "Zapisz"
    school_class.grade.should == 3
    new_school_year_time = Time.parse("Sep 5 2013")
    Time.stub!(:now).and_return(new_school_year_time)
    find(:xpath, "//a[contains(text(), 'Ustaw jako aktywny')][1]").click
    SchoolClass.find(school_class.id).grade.should == 4
  end

  scenario "it should not update 4th grade school classes to 5th when new year come" do
    school_class = FactoryGirl.create(:school_class, yearbook:2013, :teacher_id => @teacher.id)
    fill_in "semester_start_year", with: "2013"
    fill_in "semester_end_year", with: "2014"
    select "1", from: "semester_semester"
    click_button "Zapisz"
    school_class.grade.should == 4
    new_school_year_time = Time.parse("Sep 5 2013")
    Time.stub!(:now).and_return(new_school_year_time)
    find(:xpath, "//a[contains(text(), 'Ustaw jako aktywny')][1]").click
    SchoolClass.find(school_class.id).grade.should == 4
    SchoolClass.find(school_class.id).active.should be_false
  end

end
