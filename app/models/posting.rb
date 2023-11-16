class Posting < ApplicationRecord
  belongs_to :user

  validates :type_of, presence: true
  validates :subject, presence: true
  validates :description, presence: true
  validates :availability, presence: true
  validates :price, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :contact, presence: true

  def self.all_types
    return ['User', 'Professional']
  end

  def self.all_subjects
    return ['Recruitment', 'CS', 'Math', 'Physics', 'Chemistry', 'Biology', 'English', 'Languages', 'Other']
  end

  def self.with_categories(types_list, subjects_list)
    if (types_list.length == 0 or types_list.nil? or types_list.length == self.all_types.length) && (subjects_list.length == 0 or subjects_list.nil? or subjects_list.length == self.all_subjects.length)
      return Posting.all
    elsif (subjects_list.length == 0 or subjects_list.nil?)
      return Posting.where("lower(type_of) IN (?)", types_list.map(&:downcase))
    elsif (types_list.length == 0 or types_list.nil?)
      return Posting.where("lower(subject) IN (?)", subjects_list.map(&:downcase))
    end
    return Posting.where("lower(type_of) IN (?) AND lower(subject) IN (?)", types_list.map(&:downcase), subjects_list.map(&:downcase))
  end

end
