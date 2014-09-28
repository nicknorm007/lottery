# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


ready = ->

  $("#simlineup").click ->
    $("#simlineupmsg").html("Calculating.....please wait.")

  $("#simlineup").bind "ajax:complete", (event, data) ->
    $("#simlineupresult").html(data.responseText)
    $("#simlineupmsg").html("")
    return

$(document).ready(ready)
$(document).on('page:load', ready)
