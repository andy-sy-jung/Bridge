class Posting < ApplicationRecord
  belongs_to :user

  def self.all_types
    return ['User', 'Professional']
  end

  def self.with_types(types_list)
    if types_list.length == 0 or types_list.nil?
      return Posting.all
    end
    return Posting.where("lower(type_of) IN (?)", types_list.map(&:downcase))
  end

end