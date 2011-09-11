# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :item do
      title "MyString"
      permalink "MyString"
      content "MyText"
      top false
      category "MyString"
      user nil
    end
end