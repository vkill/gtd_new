# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :feedback do
      category "MyString"
      body "MyText"
      state "MyString"
      result "MyText"
      handler_id 1
      handle_at "2011-09-11 17:59:23"
      issue nil
    end
end