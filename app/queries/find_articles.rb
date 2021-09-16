# frozen_string_literal: true

class FindArticles
  attr_accessor :initial_scope

  def initialize(initial_scope)
    @initial_scope = initial_scope
  end

  def call(params)
    scoped = filter_by_author(initial_scope, params[:email])
    scoped = filter_by_category(scoped, params[:category])
    sort(scoped)
  end

  private

  def filter_by_author(scoped, email = nil)
    if email
      user = User.find_by(email: email)
      scoped.where(user_id: user.id)
    else
      scoped
    end
  end

  def filter_by_category(scoped, category = nil)
    category ? scoped.where('lower(category) = ?', category.downcase) : scoped
  end

  def sort(scoped)
    scoped.order(created_at: :desc)
  end
end
