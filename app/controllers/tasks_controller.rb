class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  def index
    @task = Task.all
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
    params.require(:task).permit(:name)
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  end
