# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :service do
      name                { Faker::LoremCN.word }
      describtion         { Faker::LoremCN.paragraph }
      category            { Service.get_category_values.map{|x| x[1]}.sample }
      expired_date_hours  { rand 168 }
      association :department
    end
end

