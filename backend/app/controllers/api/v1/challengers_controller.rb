# app/controllers/api/v1/challengers_controller.rb
module Api
  module V1
    class ChallengersController < ApplicationController
      before_action :set_challenger, only: %i[show update destroy]

      # GET /api/v1/challengers
      def index
        @challengers = Challenger.order(score: :desc)
        render json: @challengers
      end

      # GET /api/v1/challengers/:id
      def show
        render json: @challenger, include: { answers: { include: :choice } }
      end

      # POST /api/v1/challengers
      def create
        @challenger = Challenger.new(challenger_params)

        if @challenger.save
          render json: @challenger, status: :created
        else
          render json: { errors: @challenger.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/v1/challengers/:id
      def update
        if @challenger.update(challenger_params)
          render json: @challenger
        else
          render json: { errors: @challenger.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/challengers/:id
      def destroy
        @challenger.destroy
        head :no_content
      end

      private

      def set_challenger
        @challenger = Challenger.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Challenger not found' }, status: :not_found
      end

      def challenger_params
        params.require(:challenger).permit(:name, :score)
      end
    end
  end
end
