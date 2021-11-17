# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_comment, only: %i[show edit update destroy]

  def show; end

  def new
    @comment = Comment.new
  end

  def create
    @task = Task.find_by(params[:id])
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.task_id = @task.id
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @task, notice: 'El comentario fue creado con éxito.' }
        # format.json { render :show, status: :created, location: @task }
      else
        format.html { redirect_to @task, status: :unprocessable_entity }
        # format.json { render json: @house.errors, status: :unprocessable_entity }
      end
      format.js
    end
  end

  def edit; end

  def update; end

  def destroy; end

  private

  def set_user_profile
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
