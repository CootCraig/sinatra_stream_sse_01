
$(document).ready(function() {
  $(".open_close").each(function(i){
    var logdiv = $("#log")
    logdiv.text("ready func")
    var target = $(this)
    var door_id = target.attr('id')
    var url = "/door/events/" + door_id
    target.text("Get events from: " + url)
    var source = new EventSource(url)
    source.onmessage = function (event) {
      logdiv.text(event.data)
      var status_msg = JSON.parse(event.data);
      if (status_msg.open) {
        target.text("Open")
      } else {
        target.text("Closed")
      }
    };
  })
});
