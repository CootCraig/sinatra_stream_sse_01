
$(document).ready(function() {
  $(".open_close").each(function(i){
    var logdiv = $("#log")
    var target = $(this)
    var door_id = target.attr('id')
    var url = "/door/events/" + door_id
    target.text("Get events from: " + url)
    var source = new EventSource(url)

    source.onmessage = function() {
      var event_count = 0;
      return function(event){
        event_count += 1;
        logdiv.text(event.data)
        var status_msg = JSON.parse(event.data);
        if (status_msg.open) {
          target.text("Open. " + event_count + " events pushed from "+ url)
        } else {
          target.text("Closed. " + event_count + " events pushed from " + url)
        }
      };
    }();
  })
});
