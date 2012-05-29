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
semester = FactoryGirl.create(:semester, :school_id => school.id)
admin = FactoryGirl.create(:admin, :school_id => school.id)
teacher = FactoryGirl.create(:teacher, :school_id => school.id)
school_class = FactoryGirl.create(:school_class, :teacher_id => teacher.id)
director = FactoryGirl.create(:director, :school_id => school.id)
