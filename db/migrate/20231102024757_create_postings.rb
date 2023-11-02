class CreatePostings < ActiveRecord::Migration[7.1]
  def change
    create_table :postings do |t|
      t.references :user, foreign_key: true
      t.string :type_of
      t.string :name
      t.float :price
      t.string :subject
      t.text :description
      t.string :availability
      t.string :contact
    end
  end
end
