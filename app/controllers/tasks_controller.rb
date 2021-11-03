# frozen_string_literal: true

class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show; end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: 'La tarea fue creada con èxito.' }
        # format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new, status: :unprocessable_entity }
        # format.json { render json: @culo.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit; end

  def update; end

  def destroy; end

  private

  def create_params
    params.require(:task).permit(:name, :description, :category, :limit_date, :finished_date, :owner_user_id,
                                 :assignee_user_id)
  end

  def finish_params
    params.require(:task).permit(:finished_date)
  end

  def approve_params
    params.require(:task).permit(:approved_date, :reviewer_user_id)
  end
end
