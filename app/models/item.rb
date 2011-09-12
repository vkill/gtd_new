class Item < ActiveRecord::Base

  belongs_to :user
  has_many :attachments, :as => :attachmentable

  symbolize :top, :in => [ true, false ], :scopes => true, :methods => true

end


# == Schema Information
#
# Table name: items
#
#  id         :integer         not null, primary key
#  title      :string(255)
#  permalink  :string(255)
#  content    :text
#  top        :boolean         default(FALSE)
#  category   :string(255)     default("none")
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

