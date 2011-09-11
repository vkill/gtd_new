class Attachment < ActiveRecord::Base

  belongs_to :attachmentable, :polymorphic => true

  has_attached_file :data,
                    :url  => "/system/attachments/:id/:style_:basename.:extension",
                    :path => ":rails_root/public/system/attachments/:id/:style_:basename.:extension",
                    :styles => { :normal => ['400x300#', :png], :thumb => ['200x150#', :png] }
  validates_attachment_size :data, :less_than => 2.megabytes

end

