# frozen_string_literal: true

class EventsController < ApplicationController
  before_action :find_event, only: %i[show edit update destroy event_accept event_reject interested_users registered_users show_details post_comment registration_form register show_receipt]
  
  def new
    @event = Event.new
    @address = EventAddress.new
  end

  def create
    @event = Event.new(event_params)
    @event.user_id = current_user.id
    if @event.save
      flash.now[:alert] = 'Event Posted'
      redirect_to event_path(@event.id)
    else
      flash[:notice] = 'Event not Posted'
      redirect_to new_event_path
    end
  end

  def index
    if params[:query].present?
      @events = Event.search1(params[:query])
      respond_to do |format|
        format.js
      end
    else
      @events = Event.order(created_at: :desc).where(status: 'accepted')
    end
  end

  def update
    if @event.update(event_params)
      flash[:notice] = 'Event Updated'
      redirect_to event_path(@event)
    else
      flash[:notice] = 'Event not Updated'
      render 'edit'
    end
  end

  def destroy
    if @event.user_id == current_user.id
      if @event.destroy
        flash[:notice] = 'Event Deleted'
      else
        flash[:notice] = 'Event not Deleted'
      end
    else
      flash[:notice] = 'You cannot Deleted this event!!'
    end
    redirect_to events_path
  end

  def my_event
    @events = Event.where(user_id: current_user.id)
    @user = current_user
  end

  def show_interest
    @interest = Interest.new
    @interest.user_id = current_user.id
    @interest.event_id = params[:format]
    redirect_to root_path if @interest.save
  end

  def registered_events
    @registered_events = current_user.events
  end

  def event_requests
    @event_requests = Event.where(status: 'pending')
  end

  def event_accept
    @event.status = 'accepted'
    if @event.save
      flash[:notice] = 'Event Accepted'
      redirect_to event_requests_path(@event), notice: 'test'
    else
      flash[:notice] = 'Event not Accepted'
      redirect_to event_requests_path(@event)
    end
  end

  def event_reject
    @event.status = 'rejected'
    if @event.save
      flash[:notice] = 'Event Rejected'
      redirect_to event_requests_path(@event)
    else
      flash[:notice] = 'Event not Rejected'
      redirect_to event_requests_path(@event)
    end
  end

  def interested_users
    @interested_users = @event.interested_users
  end

  def registered_users
    @registered_users = @event.users
  end

  def show_details
    @event_comments = @event.comments
  end

  def post_comment
    @comment = current_user.comments.new(comment_params)
    @comment.event_id = @event.id
    if @comment.save
      flash[:notice] = 'Comment Posted'
      redirect_to show_details_path(@event.id)
    else
      flash[:notice] = 'Comment not Posted! Something is wrong!!'
      redirect_to show_details_path(@event.id) 
    end
  end

  def registration_form; end

  def register
    @register = Registration.new(registration_params)
    @register.event_id = @event.id
    @register.user_id = current_user.id
    @register.total_amount = (@event.price * @register.quantity.to_i)
    @register.status = false
    if @register.save
      flash[:notice] = 'Registered'
      redirect_to charges_path(@event.id)
    else
      flash[:notice] = 'Not Registered'
      redirect_to  root_path
    end
  end

  def show_receipt
    @registration = Registration.find_by(event_id: @event.id, user_id: current_user.id)
    @user = current_user
    respond_to do |format|
      format.html
      format.pdf {
        render template: 'events/show_receipt.html.erb',
               pdf: 'temp',
               layout: 'pdf.html'
      }
    end
  end

  private
  def find_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :description, :date, :time, :website, :user_id, :category_id, :status, :price, :size, :image, event_address_attributes: %i[address_line1 address_line2 area city pincode])
  end

  def comment_params
    params.require(:comment).permit(:comment, :user_id, :event_id, :image)
  end

  def registration_params
    params.require(:register).permit(:quantity, :user_id, :event_id)
  end
end
