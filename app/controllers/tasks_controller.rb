class TasksController < ApplicationController
  before_action :set_project
  before_action :set_task, only: %i[show edit update destroy]

  def new
    @task = @project.tasks.build
  end

  def show; end

  def create
    order = @project.size > 0 ? @project.tasks.last.order += 1 : 1 # will not properly working - id instead of order
    @task = @project.tasks.build(task_params)
    @task.owner_id = current_user.id
    @task.order = order

    respond_to do |format|
      if @task.save
        @project.update(size: @project.size += 1)
        format.html { redirect_to @project, notice: 'Task was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity, notice: 'Something went wrong' }
      end
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @project, notice: 'Task was successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @task.destroy
    @project.update(size: @project.size -= 1)

    respond_to do |format|
      format.html { redirect_to @project, notice: 'Task was successfully deleted.', status: :see_other }
    end
  end

  private

  def task_params
    params.require(:task).permit(:content, :target_date)
  end

  def set_project
    @project = Project.find(params[:project_id])

    authorize_user(@project.owner_id)
  end

  def set_task
    @task = @project.tasks.find(params[:id])
  end
end
