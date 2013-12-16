# coding: utf-8

require "acceptance/acceptance_helper"

feature "subjects" do

  let!(:school) { create(:school) }
  let!(:semester) { create(:semester, school: school) }
  let!(:teacher) { create(:teacher, school: school) }
  let!(:profile) { load_profile }
  let!(:school_class) { create(:school_class, teacher: teacher) }
  let!(:student) { create(:student, school_class: school_class) }

  context "show" do
    let!(:director) { create(:director, school: school) }
    before do
      login "teacher"
    end

    context "descriptions" do
      scenario "description popover", :js => true do
        create(:description, subject: Subject.last)
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
      let!(:description) { create(:description, subject: Subject.last) }

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
        let!(:mark) { create(:mark, description: description, student: student,
                            mark: "6") }
        before do
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
          create(:mark, subject: Subject.last, description: description,
                 student: student, mark: "6")
          visit "/teacher/subjects/#{Subject.last.id}"
          page.should have_xpath "//td[@class='mark_average'][contains(text(), '6.00')]"
        end

        scenario "when there are two marks" do
          create(:mark, subject: Subject.last, description: description,
                 student: student, mark: "6")
          description = create(:description, subject: Subject.last,
                               description: "Walce")
          create(:mark, subject: Subject.last, description: description,
                 student: student, mark: "3")
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
        let!(:mark) { create(:semestral_mark, student: student,
                             subject: Subject.last) }
        before do
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
