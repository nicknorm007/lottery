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
    maxDate: "+1M +10D"
    altField: "#recorded",
    altFormat: "yy-mm-dd"
  })