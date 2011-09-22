# Read about factories at http://github.com/thoughtbot/factory_girl

include ActionDispatch::TestProcess
FactoryGirl.define do
  factory :attachment do
      name            { Faker::LoremCN.word }
      describtion     { Faker::LoremCN.word }
      data            { fixture_file_upload(Rails.root.join('public', 'images', 'rails.png'), 'image/png', :binary) }
      download_times  { rand 1_000 }
      association :attachmentable, :factory => :software
    end
end

