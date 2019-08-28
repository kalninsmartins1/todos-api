module V1
  # Class for controlling incoming requests
  class TodosController < ApplicationController
    attr_writer :todo

    def index
      json_response(current_user.todos.paginate(page: params[:page], per_page: 20))
    end

    def show
      if todo.valid?
        json_response(todo)
      else
        head :unprocessable_entity
      end
    end

    def create
      todo = current_user.todos.build(todo_params)
      if todo.save
        json_response(todo, :created)
      else
        json_response(todo.errors.full_messages, :bad_request)
      end
    end

    def update
      if todo.update(todo_params)
        json_response(todo, :ok)
      else
        json_response(todo.errors.full_messages, :bad_request)
      end
    end

    def destroy
      if todo.destroy
        head :no_content
      else
        head :unprocessable_entity
      end
    end

    private

    def todo
      @todo ||= ValidTodoDecorator.find_in_array(current_user.todos, params[:id])
    end

    def todo_params
      params.require(:todo).permit(:title, :created_by)
    end
  end
end
