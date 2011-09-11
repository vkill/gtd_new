class Evaluation < ActiveRecord::Base

  belongs_to :evaluationable, :polymorphic => true

  symbolize :category, :in => [ :good, :bad ], :scopes => true, :methods => true

end

