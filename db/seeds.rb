# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
Posting.delete_all
postings = [{:user_id => User.first.id, :type_of => "Professional", :name => "Rutvik Rau, Boss Man", :price => 2000.0, :subject => "CS", :description => "BIG MAN WILLING TO DO BIG THINGS", :availability => "Never", :contact => "000000"},
            {:user_id => User.first.id, :type_of => "Professional", :name => "Andrew Jung", :price => 0.0, :subject => "CS", :description => "I am professional, not scammer", :availability => "Never", :contact => "000000"},
            {:user_id => User.first.id, :type_of => "Professional", :name => "Erica McGillicuddy", :price => 2000.0, :subject => "CS", :description => "I am THE networking KING", :availability => "Never", :contact => "000000"},
            {:user_id => User.first.id, :type_of => "Professional", :name => "Eithan Jahja", :price => 2000.0, :subject => "CS", :description => "Certified Professional", :availability => "Never", :contact => "000000"},
]

postings.each do |posting|
    Posting.create!(posting)
end
