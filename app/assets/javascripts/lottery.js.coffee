# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


ready = ->
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
      digits: true
    pickdate:
      required: true
      minlength: 1


  $("#play_until_win").click ->
    if $(this).is(":checked")
      $(".lotterycalendar").hide()
    else
      $(".lotterycalendar").show()

  $("#pick4form").submit (e) ->
    picklength = ($("input[name='pick']:checked").val())
    luckyLength = $("#lucky_num").val().length
    isValid = (luckyLength == parseInt(picklength))
    unless isValid
      e.preventDefault()
      e.stopPropagation()
      alert "Length of number you play must match game type!"

  $("#simulate").click ->
    $("#calcmsg").html("Calculating.....please wait.")

  $("#simulate").bind "ajax:complete", (event, data) ->
    $("#simresult").html(data.responseText)
    return

  $("#simcoinflip").click ->
    $(this).attr "href", $(this).attr("href") + "?flips=" + $("#coin_flips").val()
    return

  $("#simcoinflip").bind "ajax:complete", (event, data) ->
    $("#flipresults").html(data.responseText)
    return

  $(".simclass").bind "ajax:complete", (event, data) ->
    id = $(this).attr("id")
    $("\##{id}result").html(data.responseText)
    return

  $(".simclass").click ->
    id = $(this).attr("id")
    $("\##{id}result").html("Calculating.....please wait.")

  $("#winner").hover (->
    $("#popup").show()
    return
  ), ->
    $("#popup").hide()
    return

$(document).ready(ready)
$(document).on('page:load', ready)


