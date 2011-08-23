$(document).ready(function() {

	var date = new Date();
	var d = date.getDate();
	var m = date.getMonth();
	var y = date.getFullYear();
	
	$('#calendar').fullCalendar({
		editable: true,        
		header: {
            left: 'prev,next today',
            center: 'title',
            //right: 'month,agendaWeek,agendaDay'
            right: 'month,agendaWeek,agendaDay'
        },
        defaultView: 'agendaWeek',
        firstDay: 1, // Monday
        height: 500,
        firstHour: 8,
        slotMinutes: 30,
        
        dayNames: ['Søndag', 'Mandag', 'Tirsdag', 'Onsdag', 'Torsdag', 'Fredag', 'Lørdag'],
        dayNamesShort: ['Sø', 'Ma', 'Ti', 'On', 'To', 'Fr', 'Lø'],
        monthNames: ['Januar', 'Februar', 'Marts', 'April', 'Maj', 'Juni', 'Juli',
		 'August', 'September', 'Oktober', 'November', 'December'],
        monthNamesShort: ['Jan', 'Feb', 'Mar', 'Apr', 'Maj', 'Jun',
		 'Jul', 'Aug', 'Sep', 'Okt', 'Nov', 'Dec'],

        loading: function(bool){
            if (bool) 
                $('#loading').show();
            else 
                $('#loading').hide();
        },
        
        // a future calendar might have many sources.
        eventSources: [{
            url: '/da/bookings',
            color: 'yellow',
            textColor: 'black',
            ignoreTimezone: false
        }],
        
        titleFormat: {
          month: 'MMMM yyyy',                             // September 2009
          week: "d. [MMM][ yyyy]{ '&#8212;' d. MMM yyyy}", // 7. - 13. Sep 2009
          day: 'd. MMM, yyyy'                  // 8. Sep, 2009
        },
        columnFormat: {
            month: 'ddd',    // Mon
            week: 'ddd d/M', // Mon 7/9
            day: 'dddd d/M'  // Monday 7/9
        },
        axisFormat: 'HH:mm',
        timeFormat: 'HH:mm{ - HH:mm} ',

        //dragOpacity: "0.5",
        editable: false,
        //selectable: true,
        
        //http://arshaw.com/fullcalendar/docs/event_ui/eventDrop/
        //eventDrop: function(event, dayDelta, minuteDelta, allDay, revertFunc){
        //    updateEvent(event);
        //},

        // http://arshaw.com/fullcalendar/docs/event_ui/eventResize/
        //eventResize: function(event, dayDelta, minuteDelta, revertFunc){
        //    updateEvent(event);
        //},

        // http://arshaw.com/fullcalendar/docs/mouse/eventClick/
        eventClick: function(event, jsEvent, view){
          // would like a lightbox here.
        },

        dayClick: function(date, allDay, jsEvent, view){
          calendarSelectDate(date, allDay);
        },

	});
});

//function updateEvent(the_event) {
//    $.update(
//      "/da/bookings/" + the_event.id,
//      { calendar_event: { title: the_event.title,
//                 starts_at: "" + the_event.start,
//                 ends_at: "" + the_event.end,
//                 description: the_event.description
//               }
//      },
//      function (reponse) { alert('successfully updated event.'); }
//    );
//};


$(document).ready(function() {
  if ( $('#booking_created_at')[0] ) {
    calendarGotoDate($('#booking_created_at').val());
  }
});

function calendarGotoDate(date){
    var m = date.match(/^(\d{1,2})\.(\d{1,2})\.(\d{4})$/);
    if (m) {
      $('#calendar').fullCalendar('gotoDate', m[3], m[2]-1, m[1]);

      var startDate = $.datepicker.parseDate("dd.mm.yy", date);
      var endDate = $.datepicker.parseDate("dd.mm.yy", date);
      endDate.setDate(startDate.getDate() + 1);
      $('#calendar').fullCalendar('select', startDate, endDate, false);
    }
}

function calendarSelectDate(date, allDay){
	// get meetingroom_id from current selection in booking form
	var meetingroom_id = $('#booking_meetingroom_id').val();
	location.href = "/meetingrooms/"+meetingroom_id+"/bookings/new?date="+date+"&allDay="+allDay;
}


$.ajaxSetup({
  beforeSend: function(xhr) {
    xhr.setRequestHeader("Accept", "text/javascript");
  }
});
