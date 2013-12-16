# coding: utf-8
require 'acceptance/acceptance_helper'

feature 'school classes' do

  let!(:school) { create(:school) }
  let!(:teacher) { create(:teacher, school: school) }
  let!(:profile) { load_profile }

  context 'index' do
    let!(:semester) { create(:semester, school: school) }
    before do
      login('teacher')
      click_link "Konto"
    end

    scenario "when there is no school classes" do
      click_link 'Ustawienia klas'
      assert_info_box "Nie masz klas."
    end

    scenario "when there is school class" do
      create(:school_class, teacher: teacher)
      click_link 'Ustawienia klas'
      page.should have_xpath "//h1[contains(text(), '4 G Technik awionik 2013')]"
      page.should have_xpath "//p[contains(text(), 'Semestr: 2012/2013 Semestr 1')]"
      page.should have_xpath "//a[contains(text(), 'Wybierz semestr ')]"
      page.should have_xpath "//li[@class='active']/a[@href='/teacher/semesters/activate/#{semester.id}']"
    end

    context 'create' do
      scenario 'with valid attributes' do
        click_link 'Ustawienia klas'
        fill_in 'Litera', :with => 'G'
        select 'Technik awionik', from: 'school_class_profile'
        fill_in 'Rocznik', :with => '2013'
        click_button 'Zapisz'
        page.should have_xpath "//h1[contains(text(), '4 G Technik awionik 2013')]"
        page.should have_xpath "//li[@class='active']/a[@href='/teacher/semesters/activate/#{semester.id}']"
      end

      scenario "with empty fields" do
        click_link 'Ustawienia klas'
        click_button 'Zapisz'
        page.should have_content "nie może być puste"
      end
    end

    context 'delete' do
      let!(:school_class) { create(:school_class, teacher: teacher) }

      scenario 'active school class' do
        click_link 'Ustawienia klas'
        click_link 'Usuń'
        SchoolClass.count.should == 0
        Teacher.first.school_class.should be_nil
      end
    end

    context "activate" do
      let!(:school_class1) { create(:school_class, teacher: teacher,
                                    profile: "Technik awionik") }
      let!(:school_class2) { create(:school_class, teacher: teacher) }
      before do
        click_link 'Ustawienia klas'
      end

      scenario "older school class" do
        click_link "Ustaw jako aktywną"
        page.should have_xpath "//h1[contains(text(), '4 G Technik awionik 2013')]"
      end
    end

    context 'activate semester' do
      let!(:school_class) { create(:school_class, teacher: teacher,
                                   profile: 'Technik awionik') }

      scenario 'when another is active' do
        create(:semester, school: school, semester: 2)
        click_link 'Ustawienia klas'
        find(:xpath, "//a[@href='#']").click
        find(:xpath, "//a[@href='/teacher/semesters/activate/#{semester.id}']").click
        page.should have_content 'Semestr: 2012/2013 Semestr 1'
      end

      scenario "when it is already active" do
        click_link 'Ustawienia klas'
        find(:xpath, "//a[@href='#']").click
        find(:xpath, "//a[@href='/teacher/semesters/activate/#{semester.id}']").click
        page.should have_content 'Semestr: 2012/2013 Semestr 1'
      end
    end
  end

  scenario "story #216 create school_class when there is no semester in school" do
    login('teacher')
    click_link "Konto"
    click_link "Ustawienia klas"
    fill_in 'Litera', :with => 'G'
    select 'Technik awionik', :from => 'school_class_profile'
    fill_in 'Rocznik', :with => '2013'
    click_button 'Zapisz'
    assert_info_box "Brak aktywnego semestru."
  end

end
