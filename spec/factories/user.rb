# coding: utf-8

FactoryGirl.define do

  factory :user do
    password 'test'
    password_confirmation 'test'

    # Child of :user factory, since it's in the `factory :user` block
    factory :superadmin, :class => SuperAdmin do
      username 'superadmin'
    end

    factory :admin, :class => Admin do
      first_name 'Admin'
      last_name  'instrator'
    end

    factory :director, :class => Director do
      username  'director'
      first_name 'Dyrektoriusz'
      last_name  'Dyrekcyjny'
    end

    factory :teacher, :class => Teacher do
      username  'teacher'
      first_name 'Nauczycieliusz'
      last_name  'Testowy'
    end

    factory :student, :class => Student do
      username 'student'
      first_name 'Jacek'
      last_name 'Placek'
    end
  end

end
