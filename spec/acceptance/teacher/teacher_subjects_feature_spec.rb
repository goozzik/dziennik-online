# coding: utf-8

require "acceptance/acceptance_helper"

feature "Teacher subjects" do

  context "index" do
    before do
      FactoryGirl.create(:school)
      FactoryGirl.create(:semester, :school_id => School.last.id)
      FactoryGirl.create(:teacher, :school_id => School.last.id)
      login "teacher"
    end

    scenario "info when school class is not set" do
      click_link "Oceny"
      assert_alert_box("Najpierw dodaj klasę.")
    end

    scenario "info when school class have not subjects" do
      FactoryGirl.create(:school_class, :teacher_id => Teacher.last.id)
      click_link "Oceny"
      assert_info_box("Klasa nie ma przedmiotów.")
    end

    context "subjects" do
      before do
        FactoryGirl.create(:school_class, :teacher_id => Teacher.last.id)
        FactoryGirl.create(:subject_template)
        FactoryGirl.create(:subject, :subject_template_id => SubjectTemplate.last.id, :school_class_id => SchoolClass.last.id)
        click_link "Oceny"
      end

      scenario "info" do
        page.should have_content "Matematyka"
        page.should have_xpath "//a[@href='/teacher/subjects/#{Subject.last.id}'][contains(text(), 'Pokaż oceny')]"
        page.should have_xpath "//a[@href='/teacher/subjects/#{Subject.last.id}'][contains(text(), 'Usuń')][@data-method='delete'][@data-confirm='Jesteś pewien, że chcesz usunąć przedmiot Matematyka?']"
      end

      context "follow 'Pokaż oceny'" do

        scenario "when there is no student in school class" do
          click_link "Pokaż oceny"
          page.should have_content "Najpierw dodaj uczniów."
          assert current_path == teacher_students_path
        end

        scenario "when there is student in school class" do
          FactoryGirl.create(:student, :school_class_id => SchoolClass.last.id)
          click_link "Pokaż oceny"
          page.should have_content "Oceny"
          page.should have_content "Matematyka"
        end

      end

      scenario "follow 'Usuń'" do
        click_link "Usuń"
        assert_info_box("Klasa nie ma przedmiotów.")
      end

    end

    context "create" do
      before do
        FactoryGirl.create(:school_class, :teacher_id => Teacher.last.id)
        FactoryGirl.create(:subject_template)
        click_link "Oceny"
      end

      scenario "validate empty subject_template_id" do
        click_button "Zapisz"
        page.should have_content "nie może być puste"
      end

      scenario "with valid attributes" do
        select("Matematyka", :from => "Przedmiot")
        click_button "Zapisz"
      end

    end

  end

  context "show" do
    before do

      FactoryGirl.create(:school)
      load_semester
      FactoryGirl.create(:director, :school_id => School.last.id)
      FactoryGirl.create(:teacher, :school_id => School.last.id)
      FactoryGirl.create(:profile_template, school_id: School.last.id)
      FactoryGirl.create(:school_class, :teacher_id => Teacher.last.id, profile: "Technik awionik")
      FactoryGirl.create(:student, :school_class_id => SchoolClass.last.id)
      login "teacher"
    end

    context "descriptions" do

      scenario "description popover", :js => true do
        FactoryGirl.create(:description, :subject_id => Subject.last.id)
        visit "/teacher/subjects/#{Subject.last.id}"
        page.execute_script('$(".description").trigger("mouseover")')
        page.should have_xpath "//div[@class='popover fade right in']"
        page.should have_content "Kartkówka"
        page.should have_content "Kwadraty"
      end

      scenario "description plus button popover info", :js => true do
        visit "/teacher/subjects/#{Subject.last.id}"
        page.execute_script('$("#add_description").trigger("mouseover")')
        page.should have_xpath "//div[@class='popover fade right in']"
        page.should have_content "Dodaj nowy typ oceny"
        page.should have_content "Kliknij aby dodać nową ocenę dla klasy."
      end

      context "create", :js => true do
        before do
          visit "/teacher/subjects/#{Subject.last.id}"
          page.execute_script('$("#add_description").trigger("click")')
        end

        scenario "with valid attributes" do
          sleep(3)
          fill_in "description_desc_type", :with => "Sprawdzian"
          fill_in "description_description", :with => "Dodawanie"
          click_button "Zapisz"
          page.should have_content "Spra"
        end

        scenario "with empty fields" do
          sleep(3)
          click_button "Zapisz"
          page.should_not have_content "Spra"
        end

      end

    end

    context "marks", :js => true do
      before do
        FactoryGirl.create(:description, :subject_id => Subject.last.id)
      end

      context "create" do
        before do
          visit "/teacher/subjects/#{Subject.last.id}"
          page.execute_script('$(".mark").trigger("click")')
        end

        scenario "with valid mark" do
          fill_in "mark_active", :with => "5"
          sleep(1)
          find(:css, "#mark_active").native.send_key(:tab)
          page.should have_xpath "//td[@class='mark'][contains(text(), '5')]"
        end

        scenario "with too high mark" do
          fill_in "mark_active", :with => "7"
          sleep(1)
          find(:css, "#mark_active").native.send_key(:tab)
          page.should have_xpath "//td[@class='mark'][contains(text(), '')]"
        end

        scenario "with too low mark" do
          fill_in "mark_active", :with => "0"
          sleep(1)
          find(:css, "#mark_active").native.send_key(:tab)
          page.should have_xpath "//td[@class='mark'][contains(text(), '')]"
        end

      end

      context "update" do
        before do
          FactoryGirl.create(:mark, :description_id => Description.last.id, :student_id => Student.last.id, :mark => "6")
          visit "/teacher/subjects/#{Subject.last.id}"
          page.execute_script('$(".mark").trigger("click")')
        end

        scenario "with valid mark" do
          fill_in "mark_active", :with => "3"
          sleep(1)
          find(:css, "#mark_active").native.send_key(:tab)
          page.should have_xpath "//td[@class='mark'][contains(text(), '3')]"
        end

        scenario "with too high mark" do
          fill_in "mark_active", :with => "7"
          sleep(1)
          find(:css, "#mark_active").native.send_key(:tab)
          page.should have_xpath "//td[@class='mark'][contains(text(), '6')]"
        end

        scenario "with mark 0 (destroy)" do
          fill_in "mark_active", :with => "0"
          sleep(1)
          find(:css, "#mark_active").native.send_key(:tab)
          page.should_not have_xpath "//td[@class='mark'][contains(text(), '6')]"
        end

      end

      context "average", :js => false do

        scenario "when there is no marks" do
          visit "/teacher/subjects/#{Subject.last.id}"
          page.should have_xpath "//td[@class='mark_average'][contains(text(), '0.00')]"
        end

        scenario "when there is one mark" do
          FactoryGirl.create(:mark, subject_id:Subject.last.id, :description_id => Description.last.id, :student_id => Student.last.id, :mark => "6")
          visit "/teacher/subjects/#{Subject.last.id}"
          page.should have_xpath "//td[@class='mark_average'][contains(text(), '6.00')]"
        end

        scenario "when there are two marks" do
          FactoryGirl.create(:mark, subject_id:Subject.last.id, :description_id => Description.last.id, :student_id => Student.last.id, :mark => "6")
          FactoryGirl.create(:description, :subject_id => Subject.last.id, :description => "Walce")
          FactoryGirl.create(:mark, subject_id:Subject.last.id, :description_id => Description.last.id, :student_id => Student.last.id, :mark => "3")
          visit "/teacher/subjects/#{Subject.last.id}"
          page.should have_xpath "//td[@class='mark_average'][contains(text(), '4.50')]"
        end

      end

    end

    context "semestral marks", :js => true do

      context "create" do
        before do
          visit "/teacher/subjects/#{Subject.last.id}"
          page.execute_script('$(".semestral_mark").trigger("click")')
        end

        scenario "with valid mark" do
          fill_in "semestral_mark_active", :with => "5"
          sleep(1)
          find(:css, "#semestral_mark_active").native.send_key(:tab)
          page.should have_xpath "//td[@class='semestral_mark'][contains(text(), '5')]"
          reload_page
          page.should have_xpath "//td[@class='semestral_mark'][contains(text(), '5')]"
        end

        scenario "with to high mark" do
          fill_in "semestral_mark_active", :with => "7"
          sleep(1)
          find(:css, "#semestral_mark_active").native.send_key(:tab)
          page.should have_xpath "//td[@class='semestral_mark'][contains(text(), '')]"
          reload_page
          page.should have_xpath "//td[@class='semestral_mark'][contains(text(), '')]"
        end

        scenario "with to low mark" do
          fill_in "semestral_mark_active", :with => "0"
          sleep(1)
          find(:css, "#semestral_mark_active").native.send_key(:tab)
          page.should have_xpath "//td[@class='semestral_mark'][contains(text(), '')]"
          reload_page
          page.should have_xpath "//td[@class='semestral_mark'][contains(text(), '')]"
        end

        scenario "with nkl mark" do
          fill_in "semestral_mark_active", :with => "nkl"
          sleep(1)
          find(:css, "#semestral_mark_active").native.send_key(:tab)
          page.should have_xpath "//td[@class='semestral_mark'][contains(text(), 'nkl')]"
          reload_page
          page.should have_xpath "//td[@class='semestral_mark'][contains(text(), 'nkl')]"
        end

        scenario "with zw mark" do
          fill_in "semestral_mark_active", :with => "zw"
          sleep(1)
          find(:css, "#semestral_mark_active").native.send_key(:tab)
          page.should have_xpath "//td[@class='semestral_mark'][contains(text(), 'zw')]"
          reload_page
          page.should have_xpath "//td[@class='semestral_mark'][contains(text(), 'zw')]"
        end

      end

      context "update" do
        before do
          FactoryGirl.create(:semestral_mark, :student_id => Student.last.id, :subject_id => Subject.last.id)
          visit "/teacher/subjects/#{Subject.last.id}"
          page.execute_script('$(".semestral_mark").trigger("click")')
        end

        scenario "with valid mark" do
          fill_in "semestral_mark_active", :with => "3"
          sleep(1)
          find(:css, "#semestral_mark_active").native.send_key(:tab)
          page.should have_xpath "//td[@class='semestral_mark'][contains(text(), '3')]"
          reload_page
          page.should have_xpath "//td[@class='semestral_mark'][contains(text(), '3')]"
        end

        scenario "with to high mark" do
          fill_in "semestral_mark_active", :with => "7"
          sleep(1)
          find(:css, "#semestral_mark_active").native.send_key(:tab)
          page.should have_xpath "//td[@class='semestral_mark'][contains(text(), '5')]"
          reload_page
          page.should have_xpath "//td[@class='semestral_mark'][contains(text(), '5')]"
        end

        scenario "with to low mark" do
          fill_in "semestral_mark_active", :with => "0"
          sleep(1)
          find(:css, "#semestral_mark_active").native.send_key(:tab)
          page.should have_xpath "//td[@class='semestral_mark'][contains(text(), '5')]"
          reload_page
          page.should have_xpath "//td[@class='semestral_mark'][contains(text(), '5')]"
        end

        scenario "with nkl mark" do
          fill_in "semestral_mark_active", :with => "nkl"
          sleep(1)
          find(:css, "#semestral_mark_active").native.send_key(:tab)
          page.should have_xpath "//td[@class='semestral_mark'][contains(text(), 'nkl')]"
          reload_page
          page.should have_xpath "//td[@class='semestral_mark'][contains(text(), 'nkl')]"
        end

        scenario "with zw mark" do
          fill_in "semestral_mark_active", :with => "zw"
          sleep(1)
          find(:css, "#semestral_mark_active").native.send_key(:tab)
          page.should have_xpath "//td[@class='semestral_mark'][contains(text(), 'zw')]"
          reload_page
          page.should have_xpath "//td[@class='semestral_mark'][contains(text(), 'zw')]"
        end

      end

    end

  end

end
