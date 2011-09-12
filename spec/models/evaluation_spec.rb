require 'spec_helper'

describe Evaluation do
  it "should succeed creating a new :evaluation from the Factory" do
    _1_evaluation
  end
end


# == Schema Information
#
# Table name: evaluations
#
#  id                  :integer         not null, primary key
#  category            :string(255)
#  star_rating         :integer
#  evaluationable_id   :integer
#  evaluationable_type :string(255)
#  created_at          :datetime
#  updated_at          :datetime
#

