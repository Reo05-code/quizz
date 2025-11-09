# app/controllers/api/v1/questions_controller.rb
module Api
  module V1
    class QuestionsController < ApplicationController
      before_action :set_quiz
      before_action :set_question, only: %i[show update destroy]

      # GET /api/v1/quizzes/:quiz_id/questions
      def index
        @questions = @quiz.questions.includes(:choices)
        render json: @questions, include: :choices
      end

      # GET /api/v1/quizzes/:quiz_id/questions/:id
      def show
        render json: @question, include: :choices
      end

      # POST /api/v1/quizzes/:quiz_id/questions
      def create
        @question = @quiz.questions.new(question_params)

        if @question.save
          render json: @question, status: :created
        else
          render json: { errors: @question.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/v1/quizzes/:quiz_id/questions/:id
      def update
        if @question.update(question_params)
          render json: @question
        else
          render json: { errors: @question.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/quizzes/:quiz_id/questions/:id
      def destroy
        @question.destroy
        head :no_content
      end

      private

      def set_quiz
        @quiz = Quiz.find(params[:quiz_id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Quiz not found' }, status: :not_found
      end

      def set_question
        @question = @quiz.questions.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Question not found' }, status: :not_found
      end

      def question_params
        params.require(:question).permit(:content)
      end
    end
  end
end
