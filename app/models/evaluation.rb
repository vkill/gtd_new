class Evaluation < ActiveRecord::Base

  belongs_to :evaluationable, :polymorphic => true


  symbolize :category, :in => [ :good, :bad ], :scopes => true, :methods => true


  validates :star_rating, :presence => true,
                          :inclusion => 0..5

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

