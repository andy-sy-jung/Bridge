class Posting < ApplicationRecord
  belongs_to :user

  def self.all_types
    return ['User', 'Professional']
  end

  def self.all_subjects
    return ['Recruitment', 'CS', 'Math', 'Physics', 'Chemistry', 'Biology', 'English', 'Languages', 'Other']
  end

  def self.with_categories(types_list, subjects_list)
    if (types_list.length == 0 or types_list.nil?) && (subjects_list.length == 0 or subjects_list.nil?)
      return Posting.all
    elsif (subjects_list.length == 0 or subjects_list.nil?)
      return Posting.where("lower(type_of) IN (?)", types_list.map(&:downcase))
    elsif (types_list.length == 0 or types_list.nil?)
      return Posting.where("lower(subject) IN (?)", subjects_list.map(&:downcase))
    end
    return Posting.where("lower(type_of) IN (?) AND lower(subject) IN (?)", types_list.map(&:downcase), subjects_list.map(&:downcase))
  end

end