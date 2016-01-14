class PublicController < ApplicationController

  before_action :set_navigation
 
  def index
  	 @events = Event.sorted
  end

  def show
  	@event = Event.where(:event_url => params[:event_url]).first
  	if @event.nil?
   		redirect_to(:action => 'index')
   	else
   		render('show')
   		#show event content using show.html.erb
	   end
  end

  private

  def set_navigation
    @events = Event.sorted
  end
end
