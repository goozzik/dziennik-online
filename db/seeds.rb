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

admin = FactoryGirl.create(:admin, school_id:school.id)
