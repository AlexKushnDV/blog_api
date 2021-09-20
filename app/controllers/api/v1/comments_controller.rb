# frozen_string_literal: true

module Api
  module V1
    class CommentsController < ApplicationController
      include Paginable

      before_action :set_article, only: %i[index create destroy]
      before_action :set_comment, only: %i[destroy]
      before_action :check_login, only: %i[create destroy]
      before_action :check_owner, only: %i[destroy]

      def index
        @comments = @article.comments.page(current_page).per(per_page).all
        options = get_links_serializer_options('api_v1_article_comments_path', @comments)
        render json: CommentSerializer.new(@comments, options)
                                      .serializable_hash.to_json
      end

      def create
        @comment = @article.comments.build(comment_params)
        @comment.user_id = current_user.id
        if @comment.save
          render json: CommentSerializer.new(@comment)
                                        .serializable_hash.to_json,
                 status: :created
        else
          render json: { errors: @comment.errors }, status:
            :unprocessable_entity
        end
      end

      def destroy
        @comment.destroy
        head :no_content
      end

      private

      def comment_params
        params.require(:comment).permit(:content)
      end

      def check_owner
        head :forbidden unless @comment.user_id == current_user.id
      end

      def set_comment
        @comment = @article.comments.find(params[:id])
      end

      def set_article
        @article = Article.find(params[:article_id])
      end
    end
  end
end
