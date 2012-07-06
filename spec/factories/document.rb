#coding: utf-8

FactoryGirl.define do

  factory :document do
    name "test_dokument"
    description "testowy dokument"
    document { File.new(Rails.root.join('test', 'fixtures', 'files', 'trollface.jpeg')) }
  end

end
