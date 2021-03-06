# frozen_string_literal: true

module Api
  module V1
    class ArticlesController < ApplicationController
      include Paginable

      before_action :set_article, only: %i[show destroy]
      before_action :check_login, only: %i[create destroy]
      before_action :check_owner, only: %i[destroy]

      def index
        @articles = FindArticles.new(Article.page(current_page).per(per_page).all.decorate).call(permitted_params)
        options = get_links_serializer_options('api_v1_articles_path', @articles)
        render json: ArticleSerializer.new(@articles, options)
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
        head :forbidden unless @article.user_id == current_user.id
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
