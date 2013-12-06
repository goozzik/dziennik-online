# coding: utf-8
require 'acceptance/acceptance_helper'

feature 'Teacher school classes' do

  context 'index' do
    before do
      FactoryGirl.create(:school)
      FactoryGirl.create(:semester, :school_id => School.last.id)
      FactoryGirl.create(:teacher, :school_id => School.last.id)
      login('teacher')
      click_link "Konto"
    end

    scenario "when there is no school classes" do
      click_link 'Ustawienia klas'
      assert_info_box "Nie masz klas."
    end

    scenario "when there is school class" do
      FactoryGirl.create(:school_class, :teacher_id => Teacher.last.id)
      click_link 'Ustawienia klas'
      page.should have_xpath "//h1[contains(text(), '3 G Informatyk 2013')]"
      page.should have_xpath "//p[contains(text(), 'Semestr: 2011/2012 Semestr 1')]"
      page.should have_xpath "//a[contains(text(), 'Wybierz semestr ')]"
      page.should have_xpath "//li[@class='active']/a[@href='/teacher/semesters/activate/#{Semester.last.id}']"
    end

    context 'create' do

      scenario 'with valid attributes' do
        click_link 'Ustawienia klas'
        fill_in 'Litera', :with => 'G'
        fill_in 'Profil', :with => 'Informatyk'
        fill_in 'Rocznik', :with => '2013'
        click_button 'Zapisz'
        page.should have_xpath "//h1[contains(text(), '3 G Informatyk 2013')]"
        page.should have_xpath "//li[@class='active']/a[@href='/teacher/semesters/activate/#{Semester.last.id}']"
      end

      scenario "with empty fields" do
        click_link 'Ustawienia klas'
        click_button 'Zapisz'
        page.should have_content "nie może być puste"
      end

    end

    context 'delete' do
      before do
        FactoryGirl.create(:school_class, :teacher_id => Teacher.last.id)
      end

      scenario 'active school class' do
        click_link 'Ustawienia klas'
        click_link 'Usuń'
        assert SchoolClass.count == 0
        assert !Teacher.first.school_class
      end

      scenario 'not active school class' do
        FactoryGirl.create(:school_class, :teacher_id => Teacher.last.id)
        click_link 'Ustawienia klas'
        click_link 'Usuń'
        assert SchoolClass.count == 1
        assert Teacher.first.school_class.active
      end

    end

    context "activate" do
      before do
        FactoryGirl.create(:school_class, :teacher_id => Teacher.last.id, :profile => "Ochrona Środowiska")
        FactoryGirl.create(:school_class, :teacher_id => Teacher.last.id)
        click_link 'Ustawienia klas'
      end

      scenario "older school class" do
        click_link "Ustaw jako aktywną"
        page.should have_xpath "//h1[contains(text(), '3 G Ochrona Środowiska 2013')]"
      end

    end

    context 'activate semester' do
      before do
        FactoryGirl.create(:school_class, :teacher_id => Teacher.last.id)
      end

      scenario 'when another is active' do
        FactoryGirl.create(:semester, :school_id => School.last.id, :semester => 2)
        click_link 'Ustawienia klas'
        find(:xpath, "//a[@href='#']").click
        find(:xpath, "//a[@href='/teacher/semesters/activate/#{Semester.last.id}']").click
        page.should have_content 'Semestr: 2011/2012 Semestr 2'
      end

      scenario "when it is already active" do
        click_link 'Ustawienia klas'
        find(:xpath, "//a[@href='#']").click
        find(:xpath, "//a[@href='/teacher/semesters/activate/#{Semester.last.id}']").click
        page.should have_content 'Semestr: 2011/2012 Semestr 1'
      end

    end

  end

  scenario "story #216 create school_class when there is no semester in school" do
    FactoryGirl.create(:school)
    FactoryGirl.create(:teacher, :school_id => School.last.id)
    login('teacher')
    click_link "Konto"
    click_link "Ustawienia klas"
    fill_in 'Litera', :with => 'G'
    fill_in 'Profil', :with => 'Informatyk'
    fill_in 'Rocznik', :with => '2013'
    click_button 'Zapisz'
    assert_info_box "Brak aktywnego semestru."
  end

end
