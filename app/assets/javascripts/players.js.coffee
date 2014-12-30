# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


ready = ->

  $("#simlineup").click ->
    $("#simlineupresult").html("")
    gameURL = $("#my_url").val()
    encoded = encodeURIComponent(gameURL);
    $(this).attr "href", "/players/fantasyresults" + "?myurl=" + encoded
    $("#simlineupmsg").html("Generating lineup.....please wait.")

  $("#simlineup").bind "ajax:complete", (event, data) ->
    $("#simlineupresult").html(data.responseText)
    $("#simlineupmsg").html("")
    return

  $("#simlineupbasket").click ->
    $("#simlineupresultbasket").html("")
    gameURL = $("#my_url").val()
    encoded = encodeURIComponent(gameURL);
    $(this).attr "href", "/players/fantasybasketball" + "?myurl=" + encoded + "&game=basket"
    $("#simlineupmsgbasket").html("Generating lineup.....please wait.")

  $("#simlineupbasket").bind "ajax:complete", (event, data) ->
    $("#simlineupresultbasket").html(data.responseText)
    $("#simlineupmsgbasket").html("")
    return

$(document).ready(ready)
$(document).on('page:load', ready)
