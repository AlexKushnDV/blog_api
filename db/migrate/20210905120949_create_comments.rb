# frozen_string_literal: true

class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.text :content, null: false
      t.belongs_to :user, null: false, index: true, foreign_key: true
      t.belongs_to :article, null: false, index: true, foreign_key: true

      t.timestamps
    end
  end
end
