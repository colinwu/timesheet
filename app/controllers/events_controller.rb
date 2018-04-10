class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy, :stop_now]

  def index
    @events = Event.order("project_id,start_at").paginate(:page => params[:page])
  end

  def show
  end

  def new
    @event = Event.new(:rate => $default_rate)
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to show_project_event_url(@event.project_id), :notice => "Successfully created event."
    else
      render :action => 'new'
    end
  end

  def edit
  end

  def update
    respond_to do |fmt|
      if @event.update(event_params)
        fmt.html {redirect_to show_project_event_url(@event.project_id), :notice  => "Successfully updated event."}
        fmt.json {respond_with_bip(@event)}
      else
        fmt.html {render :action => 'edit'}
        fmt.json {respond_with_bip(@event)}
      end
    end
  end

  def destroy
    @event.destroy
    redirect_to show_project_event_url(@event.project_id), :notice => "Successfully deleted event."
  end

  def start
    @project = Project.find(params[:id])
    @event = Event.create(:project_id => @project.id, :rate => @project.rate, :start_at => Time.now)
    render :action => 'edit'
  end

  def stop_now
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:start_at, :end_at, :project_id, :invoice_id, :description, :rate)
    end
end
