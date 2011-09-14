class CalendarController < ApplicationController

  layout 'admin'
  before_filter :authenticate_user!
  main_nav_highlight :main

  def index
    @sec_nav = :calendar

    @month = (params[:month] || (Time.zone || Time).now.month).to_i
    @year = (params[:year] || (Time.zone || Time).now.year).to_i

    @shown_month = Date.civil(@year, @month)

    @event_strips = Issue.event_strips_for_month(@shown_month)
  end

end

