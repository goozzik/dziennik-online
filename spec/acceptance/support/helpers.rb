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
    if Time.now.month > 9
      FactoryGirl.create(:semester, school_id:School.last.id, semester:1, start_year:Time.now.year, end_year: Time.now.year+1)
    else
      FactoryGirl.create(:semester, school_id:School.last.id, semester:2, start_year:Time.now.year-1, end_year: Time.now.year)
    end
  end

  def load_second_semester
    semester = Semester.last
    second_semester = FactoryGirl.create(:semester, school_id:School.last.id, semester:semester.semester == 1 ? 2 : 1, start_year:semester.start_year, end_year: semester.end_year)
  end

  def load_subject_templates
    subject_templates = []
    0.upto(5).each {|i| subject_templates << FactoryGirl.create(:subject_template, name:i)}
    FactoryGirl.create(:profile_template, name: "Technik awionik", school_id: School.last.id, subject_templates: subject_templates)
    subject_templates
  end

  def load_data_for_student_semester_report(student, semester = Semester.last)
    time = Chronic.parse('monday this month')
    dates = []
    3.times do
      dates << "#{time.year}-#{time.month}-#{time.mday}"
      time += 10_080
    end
    dates.each do |date|
      FactoryGirl.create(:absence, student_id:student.id, date:date, required:30, justified:20, unexcused:0, late:5)
    end
    student.subjects.each_with_index {|subject, j| FactoryGirl.create(:semestral_mark, student_id:student.id, subject_id:subject.id, mark:(j+1).to_s)}
  end

  def load_data_for_student_year_report(school_class, student)
    load_data_for_student_semester_report(student)
    semester = school_class.semester 
    second_semester = Semester.find_by_semester(semester.semester == 1 ? 2 : 1)
    school_class.activate_semester(second_semester)
    load_data_for_student_semester_report(student)
  end

  def load_data_for_school_class_semester_report(school_class)
    1.upto(3) do
      student = FactoryGirl.create(:student, school_class_id:school_class.id)
      load_data_for_student_semester_report(student)
    end
  end

  def load_data_for_school_class_year_report(school_class)
    1.upto(3) do
      student = FactoryGirl.create(:student, school_class_id:school_class.id)
      load_data_for_student_year_report(school_class, student)
    end
  end

  def load_data_for_school_semester_report
    subject_templates = load_subject_templates
    0.upto(3) do |i|
      teacher = FactoryGirl.create(:teacher, school_id:School.last.id)
      school_class = FactoryGirl.create(:school_class, teacher_id:teacher.id, yearbook:Time.now.year+i, profile: "Technik awionik")
      load_data_for_school_class_semester_report(school_class)
    end
  end

  def load_data_for_school_year_report
    subject_templates = load_subject_templates
    0.upto(3) do |i|
      teacher = FactoryGirl.create(:teacher, school_id:School.last.id)
      school_class = FactoryGirl.create(:school_class, teacher_id:teacher.id, yearbook:Time.now.year+i, profile: "Technik awionik")
      load_data_for_school_class_year_report(school_class)
    end
  end

end

RSpec.configuration.include HelperMethods, :type => :acceptance
