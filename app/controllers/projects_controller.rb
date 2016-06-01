class ProjectsController < ApplicationController
  before_action :authenticate_user!, except: [:create]
  before_action :set_project, only: [:edit, :update, :destroy]

  respond_to :html
  respond_to :js

  def index
    @user = current_user
    if @user.soft_user?
      @projects = Project.where(soft_token: @user.soft_token)
    else
      @projects = @user.projects.all
    end
    respond_with(@projects)
  end

  def new
    @project = Project.new
    respond_with(@project)
  end

  def edit
  end

  def create
    @user = current_user
    @project = Project.new(project_params)
    if @user.soft_user?
      @project.soft_token = @user.soft_token
    elsif current_user
      @project.user = current_user
    end
    @project.save
    respond_with(@project)
  end

  def update
    @project.update(project_params)
    respond_with(@project)
  end

  def destroy
    @project.destroy
    respond_with(@project)
  end

  def show
    @project = Project.find(params[:id])
    #@project = current_user.projects.find(params[:id])
  end

  private

  def project_params
    params.require(:project).permit(:name, :budget, :start, :project_type, :owner_name, :email, :description, :phone,
                            user_attribues:[:email, :password, :password_confirmation])
  end

end