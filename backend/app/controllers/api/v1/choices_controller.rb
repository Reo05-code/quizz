# app/controllers/api/v1/choices_controller.rb
module Api
  module V1
    class ChoicesController < ApplicationController
      before_action :set_question
      before_action :set_choice, only: [:show, :update, :destroy]

      # GET /api/v1/quizzes/:quiz_id/questions/:question_id/choices
      def index
        @choices = @question.choices
        render json: @choices
      end

      # GET /api/v1/quizzes/:quiz_id/questions/:question_id/choices/:id
      def show
        render json: @choice
      end

      # POST /api/v1/quizzes/:quiz_id/questions/:question_id/choices
      def create
        @choice = @question.choices.new(choice_params)

        if @choice.save
          render json: @choice, status: :created
        else
          render json: { errors: @choice.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/v1/quizzes/:quiz_id/questions/:question_id/choices/:id
      def update
        if @choice.update(choice_params)
          render json: @choice
        else
          render json: { errors: @choice.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/quizzes/:quiz_id/questions/:question_id/choices/:id
      def destroy
        @choice.destroy
        head :no_content
      end

      private

      def set_question
        @question = Question.find(params[:question_id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Question not found' }, status: :not_found
      end

      def set_choice
        @choice = @question.choices.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Choice not found' }, status: :not_found
      end

      def choice_params
        params.require(:choice).permit(:content, :correct_answer)
      end
    end
  end
end
