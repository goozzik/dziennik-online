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

end
