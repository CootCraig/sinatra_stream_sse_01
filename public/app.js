
$(document).ready(function() {
  $(".open_close").each(function(i){
    var target = $(this)
    var door_id = target.attr('id')
    var url = "/door/events/" + door_id
    target.text("Bam! " + url)
    var source = new EventSource(url)
    source.onmessage = function (event) {
      target.text(event.data)
    };
  })
});
