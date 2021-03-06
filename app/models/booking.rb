# encoding: utf-8
class Booking < ActiveRecord::Base
  belongs_to :meetingroom

  scope :for_day, lambda { |date|
    where "booking_date BETWEEN ? AND ?",
      date.beginning_of_day, date.end_of_day
  }
  scope :overlapping, lambda { |starttime, endtime|
    where "starttime < ? AND endtime > ?",
      endtime, starttime
  }
  scope :except_this, lambda { |booking| where "bookings.id != ?", booking.id }

  validate :booking_length
  validate :bookings_cannot_overlap
  validates_numericality_of :attendees, :only_integer => true

  def booking_length
    errors.add(:endtime, "skal være efter starttime") if
      endtime <= starttime
  end

  def bookings_cannot_overlap
    errors.add(:meetingroom, "er allerede booket for det tidsrum") if
      !meetingroom.available? booking_date, starttime, endtime, self
  end


  # Calendar requires this
  scope :before, lambda {|end_time| {:conditions => ["booking_date < ?", Booking.format_date(end_time.end_of_day)] }}
  scope :after, lambda {|start_time| {:conditions => ["booking_date > ?", Booking.format_date(start_time - 1.day)] }} # !!! WTF - beginning_of_day doesn't work properly!?
  
  # need to override the json view to return what full_calendar is expecting.
  # http://arshaw.com/fullcalendar/docs/event_data/Event_Object/
  def as_json(options = {})
    {
      :id => self.id,
      :title => self.bookers_name,
      :description => self.custom_message || "",
      :start => (booking_date.beginning_of_day + starttime.hour.hours + starttime.min.minutes).rfc822,
      :end => (booking_date.beginning_of_day + endtime.hour.hours + endtime.min.minutes).rfc822,
      :allDay => false,
      :recurring => false,
      :color => meetingroom.color,
      #textColor: 'black',
      :url => Rails.application.routes.url_helpers.meetingroom_booking_path(meetingroom_id, id, :locale => 'da')
    }
  end
  
  def self.format_date(date_time)
    Time.at(date_time.to_i).to_formatted_s(:db)
  end

end
