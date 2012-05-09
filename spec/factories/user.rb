FactoryGirl.define do

  factory :user do
    password 'test'
    password_confirmation 'test'

    # Child of :user factory, since it's in the `factory :user` block
    factory :superadmin do
      superadmin true
    end

    factory :admin do
      admin true
    end

    factory :director do
      username  'director'
      first_name 'Dyrektoriusz'
      last_name  'Dyrekcyjny'
      director true
    end

    factory :teacher do
      username  'teacher'
      first_name 'Nauczycieliusz'
      last_name  'Testowy'
      teacher true
    end

    factory :student do
      student true
      username 'student1'
      first_name 'Jacek'
      last_name 'Placek'
    end
  end

end
