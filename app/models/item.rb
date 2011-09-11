class Item < ActiveRecord::Base

  belongs_to :user
  has_many :attachments, :as => :attachmentable

  symbolize :top, :in => [ true, false ], :scopes => true, :methods => true

end

