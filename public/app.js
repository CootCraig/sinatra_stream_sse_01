
$(document).ready(function() {
  $(".open_close").each(function(i){
    $("#log").text("ready func")
    var target = $(this)
    var door_id = target.attr('id')
    var url = "/door/events/" + door_id
    target.text("Bam! " + url)
    var source = new EventSource(url)
    source.onmessage = function (event) {
      $("#log").text(event.data)
      target.text(event.data)
    };
  })
});
