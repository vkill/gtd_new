# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :business do
    body          { Faker::LoremCN.paragraph }
    association :user
    association :service
  end

  factory :task do
    body          { Faker::LoremCN.paragraph }
    association :user
    association :service
    state         { :assigned }
    association :assigner, :factory => :user
    association :accepter, :factory => :user
    assign_remark { Faker::LoremCN.paragraph }
  end
end

