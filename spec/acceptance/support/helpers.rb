# coding: utf-8
module HelperMethods
  # Put helper methods you need to be available in all acceptance specs here.

  def assert_alert_box(alert)
    page.should have_xpath "//div[@class='alert fade in']"
    page.should have_xpath "//h4[@class='alert-heading'][contains(text(), '#{alert}')]"
  end

  def assert_info_box(info)
    page.should have_xpath "//div[@class='alert alert-info fade in']"
    page.should have_xpath "//h4[@class='alert-heading'][contains(text(), '#{info}')]"
  end

  def assert_error_box(error)
    page.should have_xpath "//div[@class='alert alert-error fade in']"
    page.should have_xpath "//h4[@class='alert-heading'][contains(text(), '#{error}')]"
  end

  def assert_page_header(header)
    page.should have_xpath "//div[@class='page-header']/h1[contains(text(), '#{header}')]"
  end

  def reload_page
    visit(current_path)
  end

  def load_semester
    if Time.now.month >= 9
      FactoryGirl.create(:semester, school: School.first, semester: 1,
                         start_year: Time.now.year, end_year: Time.now.year+1)
    else
      FactoryGirl.create(:semester, school: School.first, semester:2,
                         start_year: Time.now.year-1, end_year: Time.now.year)
    end
  end

  def load_second_semester
    semester = Semester.first
    FactoryGirl.create(:semester, school: School.first,
                       semester: semester.semester == 1 ? 2 : 1,
                       start_year: semester.start_year,
                       end_year: semester.end_year)
  end

  def load_subject_templates
    subject_templates = []
    0.upto(5).each do |i|
      subject_templates << FactoryGirl.create(:subject_template, name: i)
    end
    FactoryGirl.create(:profile_template, name: "Technik awionik",
                       school: School.first,
                       subject_templates: subject_templates)
    subject_templates
  end

  def load_data_for_student_semester_report(student, semester = Semester.first)
    1.upto(3) do |week|
      FactoryGirl.create(:absence, student_id: student.id,
                         month: Time.now.month, week: week,
                         required: 30, justified: 20,unexcused: 0,
                         late: 5, semester_id: semester.id )
    end
    student.subjects.each_with_index do |subject, j|
      FactoryGirl.create(:semestral_mark, student: student,
                         subject: subject, mark: (j+1).to_s,
                         semester_id: semester.id)
    end
  end

  def load_data_for_student_year_report(school_class, student)
    load_data_for_student_semester_report(student, Semester.first)
    load_data_for_student_semester_report(student, Semester.last)
  end

  def load_data_for_school_class_semester_report(school_class)
    1.upto(3) do
      student = FactoryGirl.create(:student, school_class: school_class)
      load_data_for_student_semester_report(student)
    end
  end

  def load_data_for_school_class_year_report(school_class)
    1.upto(3) do
      student = FactoryGirl.create(:student, school_class: school_class)
      load_data_for_student_year_report(school_class, student)
    end
  end

  def load_data_for_school_semester_report
    load_subject_templates
    0.upto(3) do |i|
      teacher = FactoryGirl.create(:teacher, school: School.last)
      school_class = FactoryGirl.create(:school_class, teacher: teacher,
                                        yearbook: Time.now.year+i,
                                        profile: "Technik awionik")
      load_data_for_school_class_semester_report(school_class)
    end
  end

  def load_data_for_school_year_report
    load_subject_templates
    0.upto(3) do |i|
      teacher = FactoryGirl.create(:teacher, school: School.last)
      school_class = FactoryGirl.create(:school_class, teacher: teacher,
                                        yearbook:Time.now.year+i,
                                        profile: "Technik awionik")
      load_data_for_school_class_year_report(school_class)
    end
  end

end

RSpec.configuration.include HelperMethods, :type => :acceptance
