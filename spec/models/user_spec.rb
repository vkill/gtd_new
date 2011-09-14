require 'spec_helper'

describe User do
end


# == Schema Information
#
# Table name: users
#
#  id                     :integer         not null, primary key
#  email                  :string(255)     default(""), not null
#  encrypted_password     :string(128)     default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer         default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  roles_mask             :integer         default(0)
#  username               :string(255)
#  superadmin             :boolean         default(FALSE)
#  name                   :string(255)
#  gender                 :string(255)     default("male")
#  phone_number           :string(255)
#  location               :string(255)
#  about                  :text
#  avatar_file_name       :string(255)
#  avatar_content_type    :string(255)
#  avatar_file_size       :integer
#  avatar_updated_at      :datetime
#  state                  :string(255)     default("pending")
#  department_id          :integer
#

