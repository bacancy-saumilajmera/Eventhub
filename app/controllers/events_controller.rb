class EventsController < ApplicationController

def new
    @event = Event.new
    @address = EventAddress.new
  end

  def create
    @event = Event.new(event_params.merge( user_id: current_user.id, category_id: params[:category_id], status: "pending" ))
    if @event.save
      flash[:notice] = "Event Posted"
      redirect_to event_path(@event.id)
    else
      render 'new'
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  def index
    @search = Event.ransack(params[:q])
    @event = @search.result.where(status: "accepted")
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
      if @event.update(event_params.merge( user_id: current_user.id, category_id: params[:category_id], status: "pending" ))
          flash[:notice] = "Event Updated"
          redirect_to event_path(@event)
      else
        render 'edit'
      end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    flash[:notice] = "Event Deleted"
    redirect_to events_path
  end
  
  def my_event
    @event = Event.where(user_id: current_user.id)
  end

  def show_interest
    @interest = Interest.new
    @interest.user_id = current_user.id
    @interest.event_id = params[:format]
    if @interest.save
      redirect_to action: "index"
    end 
  end

  def interested_event
    @interested_events = current_user.events
   end

   def event_requests
    @event_requests = Event.where(status: "pending")  
   end

   def event_accept
      @event = Event.find(params[:id])
      @event.status = "accepted"
      if @event.save
          flash[:notice] = "Event Accepted"
          redirect_to event_requests_path(@event)
      end
   end

   def event_reject
     @event = Event.find(params[:id])
     @event.status = "rejected"
     if @event.save  
          flash[:notice] = "Event Rejected"
          redirect_to event_requests_path(@event)
     end
   end

   def interested_users
    @event = Event.find(params[:id])
    @interested_users = @event.users
   end

  private
  def event_params
    params.require(:event).permit(:title, :description, :date, :time, :website ,:user_id, :category_id, :status, event_address_attributes: [:address_line1, :address_line2, :area, :city, :pincode])
  end
end
