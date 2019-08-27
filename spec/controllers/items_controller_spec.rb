require 'rails_helper'

RSpec.describe ItemsController, type: :controller do
  let!(:user) { create(:user) }
  let!(:todo) { create(:todo, created_by: user.id) }

  context 'destroy method' do
    let!(:item) { create(:item, todo_id: todo.id) }

    context 'valid parameters' do
      def valid_destroy
        prepare_auth_headers(user.id)
        get :destroy, params: {todo_id: todo.id, id: item.id}
      end

      it 'items count is reduced by 1' do
        expect { valid_destroy }.to change { Item.count }.by(-1)
      end
    end

    context 'invalid parameters' do
      def invalid_destroy
        prepare_auth_headers(user.id)
        get :destroy, params: {todo_id: todo.id, id: -1}
      end

      it 'items count has not changed' do
        expect { invalid_destroy }.to change { Item.count }.by(0)
      end
    end
  end

  context 'create method' do
    let!(:item) { build(:item) }

    context 'valid parameters' do
      def valid_create
        prepare_auth_headers(user.id)
        post :create, params: {todo_id: todo.id, item: {name: item.name, done: item.done}}
      end

      it 'item count increases' do
        expect { valid_create }.to change { Item.count }.by(1)
      end
    end

    context 'invalid parameters' do
      def invalid_create
        prepare_auth_headers(user.id)
        post :create, params: {todo_id: todo.id, item: {name: '', done: item.done}}
      end

      it 'item count stays the same' do
        expect { invalid_create }.to change { Item.count }.by(0)
      end
    end
  end
end
