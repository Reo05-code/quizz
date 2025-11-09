# app/controllers/api/v1/answers_controller.rb
module Api
  module V1
    class AnswersController < ApplicationController
      before_action :set_challenger, only: [:index, :create]
      before_action :set_answer, only: [:destroy]

      # GET /api/v1/challengers/:challenger_id/answers
      def index
        @answers = @challenger.answers.includes(:choice)
        render json: @answers, include: { choice: { include: :question } }
      end

      # POST /api/v1/challengers/:challenger_id/answers
      def create
        @answer = @challenger.answers.new(answer_params)

        if @answer.save
          # スコアを更新（正解の場合は+10点）
          if @answer.choice.correct_answer
            @challenger.increment!(:score, 10)
          end
          render json: @answer, status: :created
        else
          render json: { errors: @answer.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/challengers/:challenger_id/answers/:id
      def destroy
        @answer.destroy
        head :no_content
      end

      private

      def set_challenger
        @challenger = Challenger.find(params[:challenger_id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Challenger not found' }, status: :not_found
      end

      def set_answer
        @answer = Answer.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Answer not found' }, status: :not_found
      end

      def answer_params
        params.require(:answer).permit(:choice_id)
      end
    end
  end
end
