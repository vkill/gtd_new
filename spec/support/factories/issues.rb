# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :issue do
      body "MyText"
      state "MyString"
      assigner_id 1
      accepter_id 1
      assign_remark "MyText"
      assign_at "2011-09-11 17:27:33"
      solution "MyText"
      accept_at "2011-09-11 17:27:33"
      result "MyText"
      finish_at "2011-09-11 17:27:33"
      user nil
      service nil
      type "MyString"
    end
end