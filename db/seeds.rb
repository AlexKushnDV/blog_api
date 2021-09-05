# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
Comment.delete_all
Article.delete_all
User.delete_all

def category_name(user)
  user.id.even? ? 'Mystery' : 'Western'
end

5.times do
  user = User.create! email: Faker::Internet.email, password: '123456'
  puts "Created a new user: #{user.email}"
  3.times do
    article = Article.create!(
      title: Faker::Book.title,
      content: Faker::Lorem.paragraph_by_chars(number: 656, supplemental: false),
      category: category_name(user),
      date: Faker::Date.between(from: '2021-09-01', to: '2021-09-05'),
      user_id: user.id
    )
    2.times do
      comment = Comment.create!(
        content: Faker::Lorem.paragraph_by_chars(number: 800, supplemental: false),
        user_id: user.id,
        article_id: article.id
      )

      puts "Created an comment: #{comment.id}"
    end
    puts "Created an article: #{article.title}"
  end
end
