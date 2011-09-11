# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :issue do
    body          { Faker::LoremCN.paragraph }
    association :user
    association :service
  end

  factory :business do
    body          { Faker::LoremCN.paragraph }
    association :user
    association :service
  end

  factory :task do
    body          { Faker::LoremCN.paragraph }
    association :user
    association :service
    association :assigner
    association :accepter
    assign_remark { Faker::LoremCN.paragraph }
  end
end

