class ProjectsController < ApplicationController

  def index
    @projects = Project.all
  end
  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      #TicketCreatedWorker.perform_async(@ticket.id)
      redirect_to @project
    else
      render 'new'
    end
  end

  def show
    @project = Project.find(params[:id])
  end

  private

  def project_params
    params.require(:project).permit(:name, :budget, :start, :project_type, :owner_name, :email, :description, :phone)
  end
end