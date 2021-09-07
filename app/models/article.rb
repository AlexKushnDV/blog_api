# frozen_string_literal: true

class Article < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :title, :content, :user_id, presence: true
  validates :title, length: { maximum: 100 }

  scope :filter_by_category, lambda { |category|
    where('lower(category) = ?', category.downcase)
  }

  scope :filter_by_author, lambda { |author_id|
    where(user_id: author_id)
  }

  def self.search(params = {})
    articles = if params[:article_ids].present?
                 Article.find(params[:article_ids]).order(date: :desc)
               else
                 Article.all.order(date: :desc)
               end

    articles = articles.filter_by_category(params[:category]) if params[:category].present?

    if params[:email].present?
      user = User.find_by(email: params[:email])
      articles = articles.filter_by_author(user.id)
    end

    articles.each do |article|
      article.content = article.content.truncate(503)
    end

    articles
  end
end
