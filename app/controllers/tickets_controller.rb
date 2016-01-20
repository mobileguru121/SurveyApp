class TicketsController < ApplicationController
  before_action :logged_in_user
  before_action :find_event
  
  
  def index
    @event = Event.find(params[:event_id])
    @tickets = @event.tickets.sort
    authorize! :update, @event
  end

  def show
    @ticket = Ticket.find(params[:id])
  end

  def new
    @event = Event.find(params[:event_id])
    @ticket = @event.tickets.build
  end

  def create
    @ticket = Ticket.new(ticket_params)
     @ticket.save
    if @ticket.save
      flash[:success] = "Ticket created successfully!!"
      redirect_to(:action =>'index', :event_id => @event.id)
    else
      render('new')
    end
  end

  def edit
    @event = Event.find(params[:event_id])
    @ticket = @event.tickets.find(params[:id])
    authorize! :update, @event
  end

  def update
    @ticket = Ticket.find(params[:id])
    if @ticket.update_attributes(ticket_params)
      flash[:success] = "Ticket updated successfully!!"
      redirect_to event_tickets_path
    else
      render('edit')
    end
  end

  def destroy
     ticket = Ticket.find(params[:id]).destroy
     flash[:success] = "Ticket '#{ticket.ticket_name}' destroyed"
     redirect_to(:action => 'index', :event_id => @event.id)
  end

  private

  def ticket_params
    params.require(:ticket).permit(:ticket_name, :ticket_decription, :ticket_price)
  end 

  def find_event
    if params[:event_id]
      @event = Event.find(params[:event_id])
    end
  end
end
