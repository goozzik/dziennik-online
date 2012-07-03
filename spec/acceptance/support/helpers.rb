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

  def load_subjects_for_report
    1.upto(6).each do |mark|
      FactoryGirl.create(:subject_template, name:mark)
      FactoryGirl.create(:subject, subject_template_id:SubjectTemplate.last.id, school_class_id:SchoolClass.last.id)
    end
  end

  def load_data_for_student_semester_report(semester = Semester.last)
    time = Chronic.parse('monday this month')
    dates = []
    3.times do
      dates << "#{time.year}-#{time.month}-#{time.mday}"
      time += 10_080
    end
    dates.each do |date|
      FactoryGirl.create(:absence, student_id:Student.last.id, date:date, required:30, justified:20, unexcused:0, late:5)
    end
    0.upto(5).each do |mark|
      FactoryGirl.create(:semestral_mark, student_id:Student.last.id, subject_id:Subject.last.id+mark, mark:(mark+1).to_s)
    end
  end

  def load_second_semester
    semester = Semester.last
    second_semester = FactoryGirl.create(:semester, school_id:School.last.id, semester:semester.semester == 1 ? 2 : 1, start_year:semester.start_year, end_year: semester.end_year)
  end

  def load_data_for_student_year_report
    load_data_for_student_semester_report
    semester = SchoolClass.last.semester 
    second_semester = Semester.find_by_semester(semester.semester == 1 ? 2 : 1)
    SchoolClass.last.activate_semester(second_semester)
    load_data_for_student_semester_report
  end

  def load_data_for_school_class_semester_report
    1.upto(3) do
      FactoryGirl.create(:student, school_class_id:SchoolClass.last.id)
      load_data_for_student_semester_report
    end
  end

  def load_data_for_school_class_year_report
    1.upto(3) do
      FactoryGirl.create(:student, school_class_id:SchoolClass.last.id)
      load_data_for_student_year_report
    end
  end

end

RSpec.configuration.include HelperMethods, :type => :acceptance
