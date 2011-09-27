# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :role do
      name        { Faker::LoremCN.word + Faker::LoremCN.word }
      code        { Faker::LoremCN.word + Faker::LoremCN.word }
      describtion { Faker::LoremCN.word }
    end
end

