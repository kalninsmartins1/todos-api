module V2
  # Todos controller for controlling version 2 requests
  class TodosController < ApplicationController
    def index
      json_response(message: 'Hello there')
    end
  end
end
