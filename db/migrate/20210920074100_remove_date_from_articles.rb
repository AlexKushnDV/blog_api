# frozen_string_literal: true

class RemoveDateFromArticles < ActiveRecord::Migration[6.1]
  def change
    remove_column :articles, :date, :date
  end
end
