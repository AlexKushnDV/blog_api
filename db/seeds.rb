# frozen_string_literal: true

Comment.delete_all
Article.delete_all
User.delete_all

def category_name(user)
  user.id.even? ? 'Mystery' : 'Western'
end

5.times do
  user = User.create! email: Faker::Internet.email, password: '123456'

  3.times do
    article = Article.create!(
      title: Faker::Book.title,
      content: Faker::Lorem.paragraph_by_chars(number: 656, supplemental: false),
      category: category_name(user),
      user_id: user.id
    )
    2.times do
      Comment.create!(
        content: Faker::Lorem.paragraph_by_chars(number: 800, supplemental: false),
        user_id: user.id,
        article_id: article.id
      )
    end
  end
end
