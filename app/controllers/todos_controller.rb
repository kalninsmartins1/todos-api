# Class for controlling incoming requests
class TodosController < ApplicationController
  before_action :find_todo, only: [:show, :update, :destroy]

  def index
    json_response(Todo.all)
  end

  def show
    if @todo.id == -1
      head :not_found
    else
      json_response(@todo)
    end
  end

  def create
    @todo = Todo.new(todo_params)
    if @todo.save
      json_response(@todo, :created)
    else
      json_response(@todo.errors.full_messages, :bad_request)
    end
  end

  def update
    if @todo.update(todo_params)
      json_response(@todo, :ok)
    else
      json_response(@todo.errors.full_messages, :bad_request)
    end
  end

  def destroy
    if @todo.destroy
      head :no_content
    else
      head :not_found
    end
  end

  private

  def find_todo
    @todo = ValidTodoDecorator.find(params[:id])
  end

  def todo_params
    params.require(:todo).permit(:title, :created_by)
  end
end
