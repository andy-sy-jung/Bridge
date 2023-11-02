class CreatePostings < ActiveRecord::Migration[7.1]
  def change
    create_table :postings do |t|
      t.integer "user_id"
      t.string "type_of"
      t.string "name"
      t.string "subject"
      t.float "price"
      t.text "description"
      t.string "availability"
      t.string "contact"
    end
  end
end
