class TasksController < ApplicationController
  before_action :set_project, except: %i[today]
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
      notice = 'Task was successfully created.'

      if @task.save
        @project.update(size: @project.size += 1)
        format.html { redirect_to @project, notice: }
        format.turbo_stream { flash.now[:notice] = notice }
      else
        render :new, status: :unprocessable_entity, notice: 'Something went wrong'
      end
    end
  end

  def edit; end

  def update
    notice = 'Task was successfully updated.'
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @project, notice: }
        format.turbo_stream { flash.now[:notice] = notice }
      else
        render :edit, status: :unprocessable_entity
      end
    end
  end

  def destroy
    notice = 'Task was successfully deleted.'
    @task.destroy
    @project.update(size: @project.size -= 1)

    respond_to do |format|
      format.html { redirect_to @project, notice:, status: :see_other }
      format.turbo_stream { flash.now[:notice] = notice }
    end
  end

  def today
    @tasks = current_user.tasks.today
    @overdue_tasks = @tasks.select(&:overdue?)
    @today_tasks = @tasks.select(&:today?)
  end

  private

  def task_params
    params.require(:task).permit(:content, :target_date, :completed, :project_id)
  end

  def set_project
    @project = Project.find(params[:project_id])

    authorize_user(@project.owner_id)
  end

  def set_task
    @task = @project.tasks.find(params[:id])
  end
end
