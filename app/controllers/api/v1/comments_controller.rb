# frozen_string_literal: true

module Api
  module V1
    class CommentsController < ApplicationController
      before_action :set_comment, only: %i[show]
      before_action :set_article, only: %i[create destroy]
      before_action :check_login, only: %i[create]
      before_action :check_owner, only: %i[destroy]

      def show
        render json: @comment
      end

      def create
        @comment = @article.comments.build(comment_params)
        @comment.user_id = current_user&.id
        if @comment.save
          render json: @comment, status: :created
        else
          render json: { errors: @comment.errors }, status:
            :unprocessable_entity
        end
      end

      def destroy
        @comment = @article.comments.find(params[:id])
        @comment.destroy
        head :no_content
      end

      private

      def comment_params
        params.require(:comment).permit(:content)
      end

      def check_owner
        set_comment
        head :forbidden unless @comment.user_id == current_user&.id
      end

      def set_comment
        set_article
        @comment = @article.comments.find(params[:id])
      end

      def set_article
        @article = Article.find(params[:article_id])
      end
    end
  end
end
