# coding: utf-8

require "acceptance/acceptance_helper"

feature "time tables" do

  context "index" do
    let!(:school) { create(:school) }
    let!(:semester) { create(:semester, school: school) }
    let!(:teacher) { create(:teacher, school: school) }
    let!(:profile) { load_profile }
    let!(:school_class) { create(:school_class, profile: "Technik awionik",
                                 teacher: teacher) }
    let!(:student) { create(:student, school_class: school_class) }

    before do
      login "student"
    end

    scenario "when there are no time tables" do
      click_link "Plan lekcji"
      assert_info_box "Wychowawca nie uzupełnił jeszcze planu lekcji."
    end

    scenario "when there is time table" do
      time_table = create(:time_table, school_class: school_class)
      create(:lesson, time_table: time_table, subject: Subject.last,
             number: 0)
      click_link "Plan lekcji"
      page.should have_content "Poniedziałek"
      page.should have_content "5"
    end
  end

end
