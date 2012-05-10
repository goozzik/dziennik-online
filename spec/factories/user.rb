FactoryGirl.define do

  factory :user do
    password 'test'
    password_confirmation 'test'

    # Child of :user factory, since it's in the `factory :user` block
    factory :superadmin, :class => SuperAdmin do
      superadmin true
    end

    factory :admin, :class => Admin do
      admin true
    end

    factory :director, :class => Director do
      username  'director'
      first_name 'Dyrektoriusz'
      last_name  'Dyrekcyjny'
      director true
    end

    factory :teacher, :class => Teacher do
      username  'teacher'
      first_name 'Nauczycieliusz'
      last_name  'Testowy'
      teacher true
    end

    factory :student, :class => Student do
      student true
      username 'student1'
      first_name 'Jacek'
      last_name 'Placek'
    end
  end

end
