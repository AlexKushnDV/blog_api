# frozen_string_literal: true

class CreateArticles < ActiveRecord::Migration[6.1]
  def change
    create_table :articles do |t|
      t.string :title, index: true, null: false
      t.text :content, null: false
      t.string :category
      t.date :date
      t.belongs_to :user, null: false, index: true, foreign_key: true

      t.timestamps
    end
  end
end
