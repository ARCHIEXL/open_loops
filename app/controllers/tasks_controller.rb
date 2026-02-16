class TasksController < ApplicationController
  before_action :set_task, only: %i[edit update destroy toggle_complete]

  def index
    @task = Task.new

    base   = Task.incomplete
    scored = base.scored

    @unscored = base.unscored.order(created_at: :desc)

    @quick_wins = scored
      .where("effort <= 2")
      .order(updated_at: :desc)

    @later = scored
      .where("effort > 2")
      .where("importance <= 3 AND urgency <= 3")
      .order(updated_at: :desc)

    @active_projects = scored
      .where("effort > 2")
      .where("NOT (importance <= 3 AND urgency <= 3)")
      .order(updated_at: :desc)

    @completed = Task.complete.order(completed_at: :desc).limit(200)
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to root_path
    else
      index
      render :index, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @task.update(task_params)
      redirect_to root_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def toggle_complete
    @task.update!(completed_at: @task.completed_at ? nil : Time.current)
    redirect_to root_path
  end

  def destroy
    @task.destroy
    redirect_to root_path
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :importance, :urgency, :effort)
  end
end
