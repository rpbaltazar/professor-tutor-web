class StudyHour < ApplicationRecord
  belongs_to :user, class_name: 'User::Student', foreign_key: 'user_id'
end
