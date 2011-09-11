# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :evaluation do
      category "MyString"
      star_rating 1
      evaluationable nil
    end
end