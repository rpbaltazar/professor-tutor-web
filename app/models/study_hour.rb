class StudyHour < ApplicationRecord
  belongs_to :user, class_name: 'User::Student', foreign_key: 'user_id'

  def self.for_date(date = Date.today)
    timezone = 'Asia/Singapore'
    midnight = date.to_datetime.in_time_zone(timezone).at_midnight
    next_day = midnight + 1.day
    where('start_time >= ? AND start_time < ?', midnight, next_day)
  end

  def self.for_week(date = Date.today)
    beginning_of_week = date.to_datetime.beginning_of_week
    end_of_week = date.to_datetime .end_of_week
    study_schedules = where('start_time >= ? AND start_time < ?',
                            beginning_of_week,
                            end_of_week)
    study_schedules.group_by { |schedule| schedule.start_time.wday }
  end
end
