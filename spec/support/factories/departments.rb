# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :department do
      name        { Faker::LoremCN.word }
      describtion { Faker::LoremCN.paragraph }
    end
end

