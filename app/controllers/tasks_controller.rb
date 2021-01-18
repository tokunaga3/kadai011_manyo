class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  def index
    if params[:sort_expired].present?
      @tasks = Task.all.deadline_sort
    elsif Task.name_sarch(params[:sarch]) != [] && params[:sarch] != "" && params[:status].present?
      @tasks = Task.name_sarch(params[:sarch]).status_sarch(params[:status])
    elsif Task.name_sarch(params[:sarch]) != [] && params[:sarch] != ""
      @tasks = Task.name_sarch(params[:sarch])
    elsif params[:status].present?
      @tasks = Task.status_sarch(params[:status])
    else
     @tasks = Task.all.created_sort
    end
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def show
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: "タスクを編集しました！"
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice:"タスクを削除しました！"
  end

  def create
    @task = Task.create(task_params)
    if @task.save
      redirect_to new_task_path,notice: "タスクを追加しました！"
    else
      render :new
    end
  end

  def task_params
    params.require(:task).permit(:name, :content, :deadline, :status)
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  end
