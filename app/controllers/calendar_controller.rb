class CalendarController < ApplicationController

  layout 'admin'
  before_filter :authenticate_user!
  main_nav_highlight :main

  def index
    @sec_nav = :calendar

    @month = (params[:month] || (Time.zone || Time).now.month).to_i
    @year = (params[:year] || (Time.zone || Time).now.year).to_i

    @shown_month = Date.civil(@year, @month)

    @event_strips = end_of_association_chain.event_strips_for_month(@shown_month)
  end


  protected
    def end_of_association_chain
      if current_user.has_role? 'admin'
        Issue
      elsif current_user.has_role? 'chief'
        current_user.department.issues
      elsif current_user.has_role? 'staff'
        current_user.accept_issues
      else
        current_user.issues
      end
    end

end

