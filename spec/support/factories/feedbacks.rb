# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :feedback do
      category    { Feedback.get_category_values.map{|x| x[1]}.sample }
      body        { Faker::LoremCN.paragraph }
      association :issue
    end
end

