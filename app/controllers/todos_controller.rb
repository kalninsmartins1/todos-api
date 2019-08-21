# Class for controlling incoming requests
class TodosController < ApplicationController
  before_action :find_todo, only: [:show, :update, :destroy]
  def index
    @todos = Todo.all
    json_response(@todos)
  end

  def show
    if @todo.id > -1 # -1 indicates that Todo has not been found
      json_response(@todo)
    else
      json_response('Couldn\'t find Todo', :not_found)
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
    @todo.update(todo_params)
    head :no_content
  end

  def destroy
    @todo.destroy
    head :no_content
  end

  private

  def find_todo
    @todo = ValidTodoDecorator.find(params[:id])
  end

  def todo_params
    params.require(:todo).permit(:title, :created_by)
  end
end
