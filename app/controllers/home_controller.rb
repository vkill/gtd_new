class HomeController < ApplicationController

  def index
    @posts = Post.limit(5)
    @services = Service.limit(6)
    @softwares = Software.limit(6)
  end

end

