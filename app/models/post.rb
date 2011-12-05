class Post < Item

  symbolize :category, :in => [ :notify, :school_news ], :scopes => true, :methods => true


  def after_initialize
    puts "xxxxx"
  end

  def after_find
    puts "yyyyy"
  end
  
  after_initialize do
    after_initialize
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

