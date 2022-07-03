class ProjectsController < ApplicationController
  before_action :set_project, only: %i[show edit update destroy]
  before_action except: %i[inbox new create] do
    authorize_user(@project.owner_id)
  end

  def new
    @project = current_user.projects.build
  end

  def show; end

  def create
    @project = current_user.projects.build(project_params)
    @project.order = 1 # will be last_order + 1

    respond_to do |format|
      if @project.save
        format.html { redirect_to project_url(@project), notice: 'Project was successfully created.' }
      else
        render :new, status: :unprocessable_entity
      end
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to project_url(@project), notice: 'Project was successfully updated.' }
      else
        render :edit, status: :unprocessable_entity
      end
    end
  end

  def destroy
    @project.destroy

    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Project was successfully deleted.', status: :see_other }
    end
  end

  def inbox
    @inbox = current_user.projects.find_by(name: current_user.email)
  end

  private

  def project_params
    params.require(:project).permit(:name, :color, :favorite)
  end

  def set_project
    @project = Project.find(params[:id])
  end
end
