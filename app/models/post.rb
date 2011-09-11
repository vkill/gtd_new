class Post < Item

  symbolize :category, :in => [ :school_news ], :scopes => true, :methods => true

end

