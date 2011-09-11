class Software < Item

  symbolize :category, :in => [ :doc, :system, :network ], :scopes => true, :methods => true

end

