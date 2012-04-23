FactoryGirl.define do

  factory :user do
    user_name  'user1'
    first_name 'Tomasz'
    last_name  'Comasz'
    password   'user_password'
    password_confirmation 'user_password'

    # Child of :user factory, since it's in the `factory :user` block
    factory :superadmin do
      superadmin true
    end

    factory :admin do
      admin true
    end

    factory :director do
      director true
    end

    factory :teacher do
      teacher true
    end

    factory :student do
      student true
    end
  end

end
