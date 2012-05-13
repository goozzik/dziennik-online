# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
school = FactoryGirl.create(:school)
teacher = FactoryGirl.create(:teacher, :school_id => school.id)
school_class = FactoryGirl.create(:school_class, :teacher_id => teacher.id)
FactoryGirl.create(:director, :school_id => school.id)
FactoryGirl.create(:student, :school_class_id => school_class.id)
