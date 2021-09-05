# frozen_string_literal: true

module Api
  module V1
    class ArticlesController < ApplicationController
      before_action :set_article, only: %i[show]
      before_action :check_login, only: %i[create]
      before_action :check_owner, only: %i[destroy]

      def index
        render json: Article.all
      end

      def show
        render json: @article
      end

      def create
        article = current_user.articles.build(article_params)
        if article.save
          render json: article, status: :created
        else
          render json: { errors: article.errors }, status:
            :unprocessable_entity
        end
      end

      def destroy
        @article.destroy
        head :no_content
      end

      private

      def article_params
        params.require(:article).permit(:title, :content, :category, :date)
      end

      def check_owner
        set_article
        head :forbidden unless @article.user_id == current_user&.id
      end

      def set_article
        @article = Article.find(params[:id])
      end
    end
  end
end
