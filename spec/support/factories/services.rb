# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :service do
      name "MyString"
      describtion "MyText"
      category "MyString"
      expired_date_hours 1
      department nil
    end
end