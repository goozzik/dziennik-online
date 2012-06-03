# coding: utf-8
require "acceptance/acceptance_helper"

feature "Director students" do

  context "top" do
    before do
      FactoryGirl.create(:school)
      FactoryGirl.create(:semester, :school_id => School.last.id)
      FactoryGirl.create(:director, :school_id => School.last.id)
      login('director')
      click_link "Uczniowie"
    end

    scenario "when there is no student" do
      click_link "z najwyższą średnią"
      assert_info_box "Brak ocen do wyliczenia średniej."
    end

    context "when there are students" do
      before do
        FactoryGirl.create(:teacher, :school_id => School.last.id)
        FactoryGirl.create(:school_class, :teacher_id => Teacher.last.id)
        FactoryGirl.create(:student, school_class_id:SchoolClass.last.id)
      end

      scenario "when there is no average semestral marks" do
        click_link "z najwyższą średnią"
        assert_info_box "Brak ocen do wyliczenia średniej."
      end

      scenario "when there is average semestral mark" do
        FactoryGirl.create(:subject_template)
        FactoryGirl.create(:subject, subject_template_id:SubjectTemplate.last.id, school_class_id:SchoolClass.last.id)
        FactoryGirl.create(:semestral_mark, subject_id:Subject.last.id, student_id:Student.last.id)
        click_link "z najwyższą średnią"
        page.should have_content "Jacek"
        page.should have_content "Placek"
        page.should have_xpath "//td[contains(text(), '5.0')]"
      end

    end

  end 

  context "resit" do
    before do
      FactoryGirl.create(:school)
      FactoryGirl.create(:semester, school_id:School.last.id)
      FactoryGirl.create(:director, school_id:School.last.id)
      FactoryGirl.create(:teacher, school_id:School.last.id)
      FactoryGirl.create(:school_class, teacher_id:Teacher.last.id)
      FactoryGirl.create(:student, school_class_id:SchoolClass.last.id)
      login('director')
      click_link "Uczniowie"
    end

    context "when there is subject in school" do
      before do
        FactoryGirl.create(:subject_template)
        FactoryGirl.create(:subject, subject_template_id:SubjectTemplate.last.id, school_class_id:SchoolClass.last.id)
      end

      scenario "and no student with resit exam" do
        FactoryGirl.create(:semestral_mark, subject_id:Subject.last.id, student_id:Student.last.id, mark:2)
        click_link "do egzaminów poprawkowych"
        page.should have_xpath "//h2[contains(text(), 'Matematyka')]"
        assert_info_box "Brak uczniów do egzaminów poprawkowych."
      end

      scenario "and student with resit exam" do
        FactoryGirl.create(:semestral_mark, subject_id:Subject.last.id, student_id:Student.last.id, mark:1)
        click_link "do egzaminów poprawkowych"
        page.should have_xpath "//h2[contains(text(), 'Matematyka')]"
        page.should have_content "Jacek"
        page.should have_content "Placek"
        page.should have_content "3 G"
      end

    end

    scenario "when there is no subject in school" do
      click_link "do egzaminów poprawkowych"
      assert_alert_box "Wychowawcy klas nie dodali jeszcze przedmiotów."
    end

  end

end
