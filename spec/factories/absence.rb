#coding: utf-8
FactoryGirl.define do

  factory :absence do
    date "2012-05-07"
    required 33
    justified 6
    unexcused 2
    late 1
  end

end
