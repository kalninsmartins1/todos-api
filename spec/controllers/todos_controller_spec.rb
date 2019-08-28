require 'rails_helper'

RSpec.describe V1::TodosController, type: :controller do
  let!(:user) { create(:user) }

  context 'destroy method' do
    let!(:todo) { create(:todo, created_by: user.id) }

    context 'valid parameters' do
      def valid_destroy
        prepare_auth_headers(user.id)
        get :destroy, params: {id: todo.id}
      end

      it 'todos count is reduced by 1' do
        expect { valid_destroy }.to change { Todo.count }.by(-1)
      end
    end

    context 'invalid parameters' do
      def invalid_destroy
        prepare_auth_headers(user.id)
        get :destroy, params: {id: -1}
      end

      it 'todos count has not changed' do
        expect { invalid_destroy }.to change { Todo.count }.by(0)
      end
    end
  end

  context 'create method' do
    let!(:todo) { build(:todo) }

    context 'valid parameters' do
      def valid_create
        prepare_auth_headers(user.id)
        post :create, params: {todo: {title: todo.title, created_by: todo.created_by}}
      end

      it 'todo count increases' do
        expect { valid_create }.to change { Todo.count }.by(1)
      end
    end

    context 'invalid parameters' do
      def invalid_create
        prepare_auth_headers(user.id)
        post :create, params: {todo: {title: ''}}
      end

      it 'todo count stays the same' do
        expect { invalid_create }.to change { Todo.count }.by(0)
      end
    end
  end
end
