class Attachment < ActiveRecord::Base

  belongs_to :attachmentable, :polymorphic => true


  has_attached_file :data,
                    :url  => "/system/attachments/:id/:style_:basename.:extension",
                    :path => ":rails_root/public/system/attachments/:id/:style_:basename.:extension"
  validates_attachment_size :data, :less_than => 2.megabytes


  after_save :build_name

  private
    def build_name
      self.name = self.data_file_name unless self.name.blank?
    end

end


# == Schema Information
#
# Table name: attachments
#
#  id                  :integer         not null, primary key
#  name                :string(255)
#  describtion         :text
#  data_file_name      :string(255)
#  data_content_type   :string(255)
#  data_file_size      :integer
#  data_updated_at     :datetime
#  download_times      :integer         default(0)
#  attachmentable_id   :integer
#  attachmentable_type :string(255)
#  created_at          :datetime
#  updated_at          :datetime
#

