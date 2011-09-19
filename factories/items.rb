# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :post do
    title       { Faker::LoremCN.word + Faker::LoremCN.word }
    permalink   { rand(2) == 1 ? Faker::LoremCN.word : nil }
    content     { Faker::LoremCN.paragraph }
    top         { Post.get_top_values.map{|x| x[1]}.sample }
    category    { Post.get_category_values.map{|x| x[1]}.sample }
    association :user
  end

  factory :software do
    title       { Faker::LoremCN.word + rand.to_s}
    permalink   { rand(2) == 1 ? Faker::LoremCN.word : nil }
    content     { Faker::LoremCN.paragraph }
    top         { Software.get_top_values.map{|x| x[1]}.sample }
    category    { Software.get_category_values.map{|x| x[1]}.sample }
    association :user
  end
end

