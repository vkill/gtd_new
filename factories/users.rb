# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name                  { Faker::LoremCN.word }
    username              { Hz2py.do name, :join_with => '' }
    email                 { Faker::Internet.email(username) }
    password              { 123456 }
    password_confirmation { 123456 }
    gender                { User.get_gender_values.map{|x| x[1]}.sample }
    phone_number          { Faker::PhoneNumber.phone_number }
    location              { Faker::Address.city }
    about                 { Faker::LoremCN.paragraph }
    state                 { User.get_state_values.map{|x| x[1]}.sample }
    association :department
  end
end

