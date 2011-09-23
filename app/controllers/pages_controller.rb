class PagesController < HighVoltage::PagesController

  before_filter :load_find_hot_posts_and_softwares

  private
    def load_find_hot_posts_and_softwares
      case params[:id]
      when "department"
        find_hot_posts_and_softwares
      end
    end
end

