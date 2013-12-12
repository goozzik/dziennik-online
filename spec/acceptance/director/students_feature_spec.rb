# coding: utf-8
require "acceptance/acceptance_helper"

feature "students" do
  let!(:school) { create(:school) }
  let!(:profile) { create(:profile_template, school: school) }
  let!(:semestet) { create(:semester, school: school) }
  let!(:director) { create(:director, school: school) }
  let!(:teacher) { create(:teacher, school: school) }
  let!(:school_class) { create(:school_class, profile: "Technik awionik",
                               teacher: teacher) }

  before do
    login('director')
    click_link "Uczniowie"
  end

  context "top" do
    scenario "when there is no student" do
      click_link "z najwyższą średnią"
      assert_info_box "Brak ocen do wyliczenia średniej."
    end

    context "when there are students" do
      let!(:student) { create(:student, school_class: school_class) }

      scenario "when there is no average semestral marks" do
        click_link "z najwyższą średnią"
        assert_info_box "Brak ocen do wyliczenia średniej."
      end

      scenario "when there is average semestral mark" do
        subject_template = create(:subject_template)
        _subject = create(:subject, subject_template: subject_template,
                         school_class: school_class)
        create(:semestral_mark, subject: _subject, student: student)
        click_link "z najwyższą średnią"
        page.should have_content "Jacek"
        page.should have_content "Placek"
        page.should have_xpath "//td[contains(text(), '5.0')]"
      end
    end
  end

  context "resit" do
    let!(:student) { create(:student, school_class: school_class) }

    context "when there is subject in school" do
      let!(:subject_template) { create(:subject_template) }
      let!(:_subject) { create(:subject, subject_template: subject_template,
                              school_class: school_class) }

      scenario "and no student with resit exam" do
        create(:semestral_mark, subject: _subject, student: student, mark: "2")
        click_link "do egzaminów poprawkowych"
        page.should have_xpath "//h2[contains(text(), 'Matematyka')]"
        assert_info_box "Brak uczniów do egzaminów poprawkowych."
      end

      scenario "and student with resit exam" do
        create(:semestral_mark, subject: _subject, student: student, mark: "1")
        click_link "do egzaminów poprawkowych"
        page.should have_xpath "//h2[contains(text(), 'Matematyka')]"
        page.should have_content "Jacek"
        page.should have_content "Placek"
        page.should have_content "4 G"
      end
    end

    scenario "when there is no subject in school" do
      click_link "do egzaminów poprawkowych"
      assert_alert_box "Wychowawcy klas nie dodali jeszcze przedmiotów."
    end
  end

  context "classification" do
    let!(:student) { create(:student, school_class: school_class) }

    context "when there is subject in school" do
      before do
        FactoryGirl.create(:subject_template)
        FactoryGirl.create(:subject, subject_template_id:SubjectTemplate.last.id, school_class_id:SchoolClass.last.id)
      end

      scenario "and no student with classification exam" do
        FactoryGirl.create(:semestral_mark, subject_id:Subject.last.id, student_id:Student.last.id, mark:"2")
        click_link "do egzaminów klasyfikacyjnych"
        page.should have_xpath "//h2[contains(text(), 'Matematyka')]"
        assert_info_box "Brak uczniów do egzaminów klasyfikacyjnych."
      end

      scenario "and student with classification exam" do
        FactoryGirl.create(:semestral_mark, subject_id:Subject.last.id, student_id:Student.last.id, mark:"nkl")
        click_link "do egzaminów klasyfikacyjnych"
        page.should have_xpath "//h2[contains(text(), 'Matematyka')]"
        page.should have_content "Jacek"
        page.should have_content "Placek"
        page.should have_content "4 G"
      end
    end

    scenario "when there is no subject in school" do
      click_link "do egzaminów klasyfikacyjnych"
      assert_alert_box "Wychowawcy klas nie dodali jeszcze przedmiotów."
    end
  end

end
