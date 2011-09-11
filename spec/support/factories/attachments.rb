# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :attachment do
      name "MyString"
      describtion "MyText"
      data_file_name "MyString"
      data_content_type "MyString"
      data_file_size 1
      data_updated_at "2011-09-11 16:36:27"
      download_times 1
      attachmentable nil
    end
end