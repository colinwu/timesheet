class EventsController < ApplicationController
  def index
    @events = Event.order("project_id,start_at").paginate(:page => params[:page])
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new(:rate => $default_rate)
  end

  def create
    @event = Event.new(params[:event])
    if @event.save
      redirect_to show_project_event_url(@event.project_id), :notice => "Successfully created event."
    else
      render :action => 'new'
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    respond_to do |fmt|
      if @event.update_attributes(params[:event])
        fmt.html {redirect_to show_project_event_url(@event.project_id), :notice  => "Successfully updated event."}
        fmt.json {respond_with_bip(@event)}
      else
        fmt.html {render :action => 'edit'}
        fmt.json {respond_with_bip(@event)}
      end
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to show_project_event_url(@event.project_id), :notice => "Successfully deleted event."
  end

  def start
    @project = Project.find(params[:id])
    @event = Event.create(:project_id => @project.id, :rate => @project.rate, :start_at => Time.now)
    render :action => 'edit'
  end

  def stop_now
    @event = Event.find(params[:id])
    @event.update_attributes(:end_at => Time.now)
#     if @event.save
#       redirect_to show_project_event_url(@event.project_id), :notice => "Event stopped."
#     else
      render :action => 'edit'
#     end
  end

  def show_project
    @p = Project.find params[:id]
    @title = "Activity for #{@p.name}"
    @events = Event.where(['project_id = ?', params[:id]]).order('start_at DESC').paginate(:page => params[:page])
    render :action => 'index'
  end
end
