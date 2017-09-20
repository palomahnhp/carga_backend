$(document).on('turbolinks:load', function(){
  $.datepicker.setDefaults($.datepicker.regional["es"]);
  $("#datepicker_start").datepicker({ dateFormat: 'dd-mm-yy' });
  $("#datepicker_end").datepicker({ dateFormat: 'dd-mm-yy' });
  $("#datepicker_start_select_button").on('click', function(){
    $("#datepicker_start").datepicker("show");
  });
  $("#datepicker_start_clear_button").on('click', function(){
    $("#datepicker_start").val("");
  });
  $("#datepicker_end_select_button").on('click', function(){
    $("#datepicker_end").datepicker("show");
  });
  $("#datepicker_end_clear_button").on('click', function(){
    $("#datepicker_end").val("");
  });
  $("#datepicker_start").keypress(function (evt) {
    evt.preventDefault();
  });
  $("#datepicker_end").keypress(function (evt) {
    evt.preventDefault();
  });
  $("#tooltip-select-start").hide();
  $("#tooltip-clear-start").hide();
  $("#tooltip-select-end").hide();
  $("#tooltip-clear-end").hide();
  $("#datepicker_start_select_button").on("mouseover", function(){
    $("#tooltip-select-start").show();
  });
  $("#datepicker_start_select_button").on("mouseout", function(){
    $("#tooltip-select-start").hide();
  });
  $("#datepicker_start_clear_button").on("mouseover", function(){
    $("#tooltip-clear-start").show();
  });
  $("#datepicker_start_clear_button").on("mouseout", function(){
    $("#tooltip-clear-start").hide();
  });
  $("#datepicker_end_select_button").on("mouseover", function(){
    $("#tooltip-select-end").show();
  });
  $("#datepicker_end_select_button").on("mouseout", function(){
    $("#tooltip-select-end").hide();
  });
  $("#datepicker_end_clear_button").on("mouseover", function(){
    $("#tooltip-clear-end").show();
  });
  $("#datepicker_end_clear_button").on("mouseout", function(){
    $("#tooltip-clear-end").hide();
  });
});