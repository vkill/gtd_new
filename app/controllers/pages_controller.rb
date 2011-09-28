class PagesController < HighVoltage::PagesController

  before_filter :load_find_hot_posts_and_softwares
  layout :layout_for_page

  private
    def load_find_hot_posts_and_softwares
      case params[:id]
      when "department"
        find_hot_posts_and_softwares
      end
    end

    def layout_for_page
      case params[:id]
      when 'sitemap'
        'application'
      else
        'application'
      end
    end
end

