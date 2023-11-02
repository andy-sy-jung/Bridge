# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
postings = [{:id => 123, :description => "Rutvik Rau, Boss Man", :price => 2000, :availability => "ALWAYS"},
            {:id => 124, :description => "Andrew Jung", :price => 0, :availability => "NEVER"},
            {:id => 123, :description => "Erica McGillicuddy", :price => 2000, :availability => "ALWAYS"},
            {:id => 123, :description => "Eithan Jahja", :price => 2000, :availability => "ALWAYS"},
]

postings.each do |posting|
    Posting.create!(posting)
end
