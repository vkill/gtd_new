class Item < ActiveRecord::Base

  belongs_to :user
  has_many :attachments, :as => :attachmentable, :dependent => :destroy
  accepts_nested_attributes_for :attachments, :allow_destroy => true



  symbolize :top, :in => [ true, false ], :scopes => true, :methods => true


  delegate :name, :to => :user, :prefix => true, :allow_nil => true


  default_scope order('created_at DESC')


  validates :user, :existence => { :both => false }
  validates :title, :presence => true,
                    :uniqueness => true,
                    :length => { :maximum => 40 }
  validates :content, :presence => true,
                      :length => { :minimum => 2 }


  before_save :build_permalink
  before_validation :build_user


  def to_param
    "%s-%s" % [id, permalink.parameterize]
  end


  private
    def build_permalink
      self.permalink = Hz2py.do(self.title).parameterize unless self.permalink.blank?
    end

    def build_user
      self.user = User.current
    end
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

