class ProjectsController < ApplicationController
  def index
    @projects = Project.order(:name).paginate(:page => params[:page])
    @open_events = Hash.new
    @projects.each do |p|
      e = Event.where(["project_id = ? and end_at is NULL", p.id]).first
      @open_events[p.id] = e.id unless e.nil?
    end
  end

  def stop
    @project = Project.find(params[:id])
    @event = Event.where(["project_id = ? AND end_at is NULL", @project.id]).first
#     if @event.update_attributes(:end_at => Time.now)
#       redirect_to events_url, :notice => "Event stopped."
#     else
    @event.update_attributes(:end_at => Time.now)
      redirect_to edit_event_path(@event)
#     end
  end

  def show
    @project = Project.find(params[:id])
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(params[:project])
    if @project.save
      redirect_to @project, :notice => "Successfully created project."
    else
      render :action => 'new'
    end
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    if @project.update_attributes(params[:project])
      redirect_to @project, :notice  => "Successfully updated project."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    redirect_to projects_url, :notice => "Successfully destroyed project."
  end
end
