# coding: utf-8
require 'acceptance/acceptance_helper'

feature "school classes" do

  let!(:school) { create(:school) }
  let!(:profile) { create(:profile_template, school: school) }
  let!(:semester) { create(:semester, school: school) }
  let!(:director) { create(:director, school: school) }

  context "index" do
    before do
      login('director')
    end

    scenario "there is no active school class in school" do
      click_link "Klasy"
      assert_info_box "Szkoła nie ma aktywnych klas."
    end

    scenario "when there is active school class in school" do
      teacher = create(:teacher, school: school)
      create(:school_class, teacher: teacher, profile: "Technik awionik",
             yearbook: semester.end_year)
      click_link "Klasy"
      page.should have_content "4 G Technik awionik #{semester.end_year}"
    end

    context "follow 'Bieżąca frekwencja'" do
      let!(:teacher) { create(:teacher, school: school) }
      let!(:school_class) { create(:school_class, teacher: teacher,
                                   profile: "Technik awionik",
                                   yearbook: semester.end_year) }
      before do
        click_link "Klasy"
      end

      scenario "when there is no students" do
        click_link "Bieżąca frekwencja"
        assert_alert_box "Wychowawca klasy nie dodał jeszcze uczniów."
      end

      scenario "when there is student" do
        create(:student, school_class: school_class)
        click_link "Bieżąca frekwencja"
        page.should have_content "Frekwencja klasy 4 G"
      end
    end

    context "follow 'Bieżące Oceny'" do
      let!(:teacher) { create(:teacher, school: school) }
      let!(:school_class) { create(:school_class, profile: "Technik awionik",
                                   teacher: teacher) }
      before do
        click_link "Klasy"
      end

      context "when there is student" do
        let!(:student) { create(:student, school_class: school_class) }
        let!(:subject_template) { create(:subject_template) }
        let!(:subject) { create(:subject, subject_template: subject_template,
                                school_class: school_class) }

        scenario "and subject" do
          click_link "Bieżące oceny"
          page.should have_content "Oceny klasy 4 G"
        end
      end

      scenario "when there is no students" do
        click_link "Bieżące oceny"
        assert_alert_box "Wychowawca klasy nie dodał jeszcze uczniów."
      end
    end
  end

end
