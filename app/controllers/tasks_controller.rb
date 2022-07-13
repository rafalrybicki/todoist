class TasksController < ApplicationController
  include TasksHelper
  before_action :set_project, except: %i[today]
  before_action :set_task, only: %i[show edit update destroy]

  def new
    @task = @project.tasks.build
  end

  def show; end

  def create
    @task = @project.tasks.build(task_params)
    @task.owner_id = current_user.id
    @task.order = 1 # @project.size > 0 ? @project.tasks.last.order + 1 : 1 new scope is needed?

    respond_to do |format|
      if @task.save
        @project.update(size: @project.size += 1)
        @update_today_tasks_size = update_today_tasks_size?(({ target_date: @task.target_date }))
        notice = 'Task was successfully created.'

        format.html { redirect_to @project, notice: }
        format.turbo_stream { flash.now[:notice] = notice }
      else
        render :new, status: :unprocessable_entity, notice: 'Something went wrong'
      end
    end
  end

  def edit; end

  def update
    updated_task = {
      prev_completed: @task.completed,
      prev_target_date: @task.target_date
    }

    respond_to do |format|
      if @task.update(task_params)
        updated_task[:completed] = @task.completed
        updated_task[:target_date] = @task.target_date

        @update_today_tasks_size = update_today_tasks_size?(updated_task)
        notice = 'Task was successfully updated.'

        format.html { redirect_to @project, notice: }
        format.turbo_stream { flash.now[:notice] = notice }
      else
        render :edit, status: :unprocessable_entity
      end
    end
  end

  def destroy
    @task.destroy
    @project.update(size: @project.size -= 1)
    @update_today_tasks_size = update_today_tasks_size?({ target_date: @task.target_date })
    notice = 'Task was successfully deleted.'

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
