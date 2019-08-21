# Class for controlling item requests
class ItemsController < ApplicationController
  before_action :find_todo, only: [:index, :create]
  before_action :find_item, only: [:show, :update, :destroy]
  ITEM_NOT_FOUND_MESSAGE = 'Couldn\'t find Item'.freeze

  def index
    if @todo.id > -1
      json_response(@todo.items.all)
    else
      json_response('Couldn\'t find Todo', :not_found)
    end
  end

  def show
    if @item.id > -1
      json_response(@item)
    else
      json_response(ITEM_NOT_FOUND_MESSAGE, :not_found)
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
    if @item.id == -1
      json_response(ITEM_NOT_FOUND_MESSAGE, :not_found)
    elsif @item.update(item_params)
      head :no_content
    else
      json_response(@item.errors.full_messages, :bad_request)
    end
  end

  def destroy
    @item.destroy
    head :no_content
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
