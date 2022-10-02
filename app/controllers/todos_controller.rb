class TodosController < ApplicationController
    def index
        @todos = Todo.all
        render json: @todos
    end    

    def show
        @todo = Todo.find(params[:id])
        render json: @todo

        # handling no record error
        rescue ActiveRecord::RecordNotFound => error
            render json: {message: error.message}
    end

    def create
        @todo = Todo.new(params.require(:todo).permit(:title, :description))

        if @todo.save
            render json: {message: 'Data created succesfully'}
        else 
            render json: @todo.errors, status: :unprocessable_entity
        end
    end

    def update
        @todo = Todo.find(params[:id])

        if @todo.update(params.require(:todo).permit(:title, :description))
            render json: {message: 'Data updated succesfully'}
        else 
            render json: @todo.errors, status: :unprocessable_entity
        end

        # handling no record error
        rescue ActiveRecord::RecordNotFound => error
            render json: {message: error.message}
    end

    def destroy
        @todo = Todo.find(params[:id])

        @todo.destroy
        render json: {message: 'Data deleted succesfully'}
        
        # handling no record error
        rescue ActiveRecord::RecordNotFound => error
            render json: {message: error.message}
    end
end
