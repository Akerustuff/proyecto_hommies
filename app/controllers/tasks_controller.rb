# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy finish_task approve_task reject_task]

  def index
    @house = House.find_by(id: current_user.house_id)
    @q = @house.house_tasks(current_user).ransack(params[:q])
    @tasks = @q.result(distinct: true)
  end

  def show
    @comments = Comment.where(task_id: @task.id).order('created_at DESC').page params[:page]
    @comment = Comment.new
  end

  def new
    @users = User.where(house_id: current_user.house_id)
    @task = Task.new
  end

  def create
    @task = Task.new(create_params)
    @task.owner_id = current_user.id
    @task.house_id = current_user.house_id
    @task.assign unless @task.assignee_id.nil?
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

  def edit
    @users = User.where(house_id: current_user.house_id)
  end

  def update
    @task.update(create_params)
    @task.assign if @task.created? && !@task.assignee_id.nil?
    @task.unassign if @task.assigned? && @task.assignee_id.nil?
    respond_to do |format|
      if @task.update(create_params)
        format.html { redirect_to @task, notice: 'La tarea ha sido actualizada.' }
        # format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        # format.json { render json: @culo.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @task.destroy
    @house = current_user.house_id
    respond_to do |format|
      format.html { redirect_to house_path(@house), notice: 'La tarea ha sido eliminada.' }
      format.json { head :no_content }
    end
  end

  def finish_task
    @task.finish
    @task.finished_date = Time.current
    @task.save
    respond_to do |format|
      format.html { redirect_to @task, notice: 'Has finalizado la tarea.' }
    end
  end

  def reject_task
    @task.reject
    @task.finished_date = nil
    @task.save
    respond_to do |format|
      format.html { redirect_to @task, notice: 'Has rechazado la tarea.' }
    end
  end

  def approve_task
    @task.approve
    @task.approved_date = Time.current
    @task.save
    respond_to do |format|
      format.html { redirect_to @task, notice: 'Has aprobado la tarea.' }
    end
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def create_params
    params.require(:task).permit(:name, :description, :category, :limit_date, :owner_id,
                                 :assignee_id)
  end

  def finish_params
    params.require(:task).permit(:finished_date)
  end

  def approve_params
    params.require(:task).permit(:approved_date, :reviewer_id)
  end
end
