# Class for controlling item requests
class ItemsController < ApplicationController
  attr_writer :item
  attr_writer :todo

  def index
    if todo.valid?
      json_response(todo.items.all)
    else
      head :unprocessable_entity
    end
  end

  def show
    if item.valid?
      json_response(item)
    else
      head :unprocessable_entity
    end
  end

  def create
    if todo.valid?
      item = todo.items.build(item_params)
      if item.save
        json_response(item, :created)
      else
        json_response(item.errors.full_messages, :bad_request)
      end
    else
      head :unprocessable_entity
    end
  end

  def update
    if item.update(item_params)
      json_response(item, :ok)
    else
      json_response(item.errors.full_messages, :bad_request)
    end
  end

  def destroy
    if item.destroy
      head :no_content
    else
      head :unprocessable_entity
    end
  end

  private

  def todo
    @todo ||= ValidTodoDecorator.find_in_array(current_user.todos, params[:todo_id])
  end

  def item
    @item ||= ValidItemDecorator.find_in_array(todo.items, params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :done)
  end
end
