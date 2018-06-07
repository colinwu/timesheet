class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]
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
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      redirect_to @project, :notice => "Successfully created project."
    else
      render :action => 'new'
    end
  end

  def edit
  end

  def update
    if @project.update_attributes(project_params)
      redirect_to projects_url, :notice  => "Successfully updated project."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @project.destroy
    redirect_to projects_url, :notice => "Successfully destroyed project."
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :description, :contact_id, :rate)
  end
end
