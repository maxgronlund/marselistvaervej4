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
        
        timeFormat: 'HH:mm{ - HH:mm} ',

        //dragOpacity: "0.5",
        editable: false,
        
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
          location.href = "/meetingrooms/1/bookings/new?date="+date+"&allDay="+allDay
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
  calendarGotoDate($('#booking_created_at').val());
});

function calendarGotoDate(date){
    var m = date.match(/^(\d{1,2})\.(\d{1,2})\.(\d{4})$/);
    (m) ? $('#calendar').fullCalendar('gotoDate', m[3], m[2]-1, m[1]) : null;
    (m) ? $('#calendar').fullCalendar('highlightDate', m[3], m[2]-1, m[1]) : null;
}


$.ajaxSetup({
  beforeSend: function(xhr) {
    xhr.setRequestHeader("Accept", "text/javascript");
  }
});
