require 'spec_helper'

describe Attachment do
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

