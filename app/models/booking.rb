# encoding: utf-8
class Booking < ActiveRecord::Base
  belongs_to :meetingroom

  scope :for_day, lambda { |date|
    where "created_at BETWEEN ? AND ?",
      date.beginning_of_day, date.end_of_day
  }
  scope :overlapping, lambda { |starttime, endtime|
    where "starttime < ? AND endtime > ?",
      endtime, starttime
  }

  validate :booking_length
  validate :bookings_cannot_overlap
  validates_numericality_of :attendees, :only_integer => true

  def booking_length
    errors.add(:endtime, "skal være efter starttime") if
      endtime <= starttime
  end

  def bookings_cannot_overlap
    errors.add(:meetingroom, "er allerede booket for det tidsrum") if
      meetingroom.available? created_at, starttime, endtime
  end

end
