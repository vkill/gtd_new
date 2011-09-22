# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :evaluation do
      category      { Evaluation.get_category_values.map{|x| x[1]}.sample }
      star_rating   { (1..5).to_a.sample }
    end
end

