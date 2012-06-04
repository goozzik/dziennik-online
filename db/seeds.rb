# coding: utf-8
#
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

SubjectTemplate.create([{:name => "Administracja sieci"}, {:name => "Aplikajce biurowe" }, {:name => "Biologia"},
                {:name => "Chemia"}, {:name => "Edukacja europejska"}, {:name => "Fizyka"}, {:name => "Geografia"},
                {:name => "Grafika"}, {:name => "Historia"}, {:name => "Informatyka"}, {:name => "J.Angielski"},
                {:name => "J.Francuski"}, {:name => "J.Hiszpański"}, {:name => "J.Niemiecki"}, {:name => "J.Polski"},
                {:name => "J.Rosyjski"}, {:name => "J.Wloski"}, {:name => "Maszynoznawstwo"}, {:name => "Matematyka"},
                {:name => "Podstawy przedsiębierczości"}, {:name => "PSIO"}, {:name => "Podstawy Technologi Maszyn"},
                {:name => "Programowanie"}, {:name => "Przyroda"}, {:name => "Psychologia"}, {:name => "Religia"},
                {:name => "Systemy operacyjne"}, {:name => "Technologia informacyjna"},
                {:name => "Urządzenia techniki komputerowej"}, {:name => "Wychowanie fizyczne"},
                {:name => "Wiedza o kulturze"}, {:name => "Wiedza o społeczeństwie"}])

school = FactoryGirl.create(:school)
semester = FactoryGirl.create(:semester, school_id:school.id, start_year:2011, end_year:2012, semester:2)
admin = FactoryGirl.create(:admin, school_id:school.id, username:"administrator")

1.upto(4) do |a|
  teacher = FactoryGirl.create(:teacher, school_id:school.id, username:"nauczyciel#{a}")
  school_class = FactoryGirl.create(:school_class, teacher_id:teacher.id, yearbook:2016-a)
  1.upto(21).each do |b|
    student = FactoryGirl.create(:student, school_class_id:school_class.id, username:"Testiusz#{b}")
    ['2012-03-05', '2012-04-02', '2012-04-09', '2012-04-16', '2012-04-30', '2012-05-07', '2012-05-14', '2012-05-21', '2012-06-04', '2012-06-11', '2012-06-18', '2012-06-25'].each do |c|
      FactoryGirl.create(:absence, student_id:student.id, date:c, required:30, justified:b+1, unexcused:1)
    end
  end
end
director = FactoryGirl.create(:director, school_id:school.id, username:"dyrektor")
