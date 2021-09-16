# frozen_string_literal: true

module Api
  module V1
    class ArticlesController < ApplicationController
      before_action :set_article, only: %i[show]
      before_action :check_login, only: %i[create]
      before_action :check_owner, only: %i[destroy]

      def index
        @articles = FindArticles.new(Article.all.decorate).call(permitted_params)
        render json: ArticleSerializer.new(@articles)
                                      .serializable_hash.to_json
      end

      def show
        options = { include: [:user] }
        render json: ArticleSerializer.new(@article, options)
                                      .serializable_hash.to_json
      end

      def create
        article = current_user.articles.build(article_params)
        if article.save
          render json: ArticleSerializer.new(article)
                                        .serializable_hash.to_json,
                 status: :created
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

      def permitted_params
        params.permit(:category, :email, :format)
      end
    end
  end
end
