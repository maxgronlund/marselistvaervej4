module BookingsHelper
  def meetingrooms
    Meetingroom.order('title DESC')
  end

  def meetingrooms_select
    meetingrooms.map { |meetingroom| [meetingroom.title, meetingroom.id] }
  end

  def user_select
    User.order('name DESC').map { |user| [user.name, user.name] }
  end
end
