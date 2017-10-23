$(document).keypress(function(event) {
  if (event.keyCode === 10 || event.keyCode === 13) {
    $("#search_button").click();
  }
});