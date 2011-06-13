class BookingsController < InheritedResources::Base
  load_and_authorize_resource
  belongs_to :meetingroom , :optional => true
  
  
end
