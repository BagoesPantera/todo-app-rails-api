class TodosController < ApplicationController
    def index
        @todos = Todo.all
        render json: @todos
    end    

    def show
        @todo = Todo.find(params[:id])
        render json: @todo
    end

    def create
        @todo = Todo.new(params.require(:todo).permit(:title, :description))

        if @todo.save
            render json: @todo
        else 
            render json: @todo.errors, status: :unprocessable_entity
        end
    end

    def update
        @todo = Todo.find(params[:id])

        if @todo.update(params.require(:todo).permit(:title, :description))
            render json: @todo
        else 
            render json: @todo.errors, status: :unprocessable_entity
        end

    end
end
