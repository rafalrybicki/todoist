class ProjectsController < ApplicationController
  before_action :set_project, only: %i[show edit update destroy]

  def show; end

  def new; end

  def edit; end

  def create; end

  def update; end

  def destroy; end

  def set_project
    @project = current_user.projects.find(params[:id])
  end
end
