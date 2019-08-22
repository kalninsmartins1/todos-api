# Class for controlling item requests
class ItemsController < ApplicationController
  before_action :find_todo, only: [:index, :create]
  before_action :find_item, only: [:show, :update, :destroy]

  def index
    if @todo.id == -1
      head :not_found
    else
      json_response(@todo.items.all)
    end
  end

  def show
    if @item.id == -1
      head :not_found
    else
      json_response(@item)
    end
  end

  def create
    @item = Item.new(item_params)
    @todo = ValidTodoDecorator.find(params[:todo_id])
    @item.todo_id = @todo.id

    if @item.save
      json_response(@item, :created)
    else
      json_response(@item.errors.full_messages, :bad_request)
    end
  end

  def update
    if @item.update(item_params)
      json_response(@item, :ok)
    else
      json_response(@item.errors.full_messages, :bad_request)
    end
  end

  def destroy
    if @item.destroy
      head :no_content
    else
      head :not_found
    end
  end

  private

  def find_todo
    @todo = ValidTodoDecorator.find(params[:todo_id])
  end

  def find_item
    @item = ValidItemDecorator.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :done)
  end
end
