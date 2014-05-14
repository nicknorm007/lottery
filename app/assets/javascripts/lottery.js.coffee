# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(document).on "ready page:change", ->
  $('#bag').click (e) ->
    window.location.href = "/lottery"

  $(".datepicker").datepicker({
    showOn: "button",
    buttonImage: "/assets/calendar.gif",
    buttonImageOnly: true
    minDate: +1,
    maxDate: "+5Y +10D"
    altField: "#recorded",
    altFormat: "yy-mm-dd"
  }).datepicker "setDate", new Date()

  $("#pick4form").validate rules:
    lucky_num:
      required: true
      minlength: 1
    pickdate:
      required: true
      minlength: 1


  $("#play_until_win").click ->
    if $(this).is(":checked")
      $(".lotterycalendar").hide()
    else
      $(".lotterycalendar").show()






