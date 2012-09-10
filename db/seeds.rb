# coding: utf-8
#
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#

school = FactoryGirl.create(:school)

tzn = File.new("profile_tzn.txt", "r")

profile = nil
while (line = tzn.gets)
  if line =~ /profil:/
    line = line.gsub("\n", "")
    profile = ProfileTemplate.create(name: line.scan(/:([^"]*):/).first.first, start_year: line[-4..-1], school_id: school)
  else
    profile.subject_templates << SubjectTemplate.find_or_create_by_name(line.gsub("\n", ""))
  end
end

semester = FactoryGirl.create(:semester, school_id:school.id, start_year:2011, end_year:2012, semester:2)
admin = FactoryGirl.create(:admin, school_id:school.id, username:"administrator")
director = FactoryGirl.create(:director, school_id:school.id, username:"dyrektor")

1.upto(4) do |a|
  teacher = FactoryGirl.create(:teacher, school_id:school.id, username:"nauczyciel#{a}")
  school_class = FactoryGirl.create(:school_class, teacher_id:teacher.id, yearbook:2016-a, profile:"Technik awionik")
  1.upto(21).each do |b|
    student = FactoryGirl.create(:student, school_class_id:school_class.id, username:"Testiusz#{b}")
    ['2012-03-05', '2012-04-02', '2012-04-09', '2012-04-16', '2012-04-30', '2012-05-07', '2012-05-14', '2012-05-21', '2012-06-04', '2012-06-11', '2012-06-18', '2012-06-25'].each do |c|
      FactoryGirl.create(:absence, student_id:student.id, date:c, required:30, justified:b+1, unexcused:1)
    end
  end
end
