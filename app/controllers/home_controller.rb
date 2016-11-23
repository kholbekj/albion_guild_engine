class HomeController < ApplicationController
  def show
  end

  def calendar
    @events = Event.all
  end
end
