class CreatePostings < ActiveRecord::Migration[7.1]
  def change
    create_table :postings do |t|
        t.integer "user_id"
        t.string "description"
        t.float "price"
        t.string "availability"
    end
  end
end
