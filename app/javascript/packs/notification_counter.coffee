class Notifications
  constructor: ->
    @notifications = $("[data-behavior='notifications']")
    @setup() if @notifications.length > 0

  
  setup: ->
    $.ajax(
      url: "/notifications.json"
      dataType: "JSON"
      method: "GET"
      success: @handleSuccess
    )

  handleSuccess: (data2) =>
    if Object.keys(data2).length != 0
      noti_length = Object.keys(data2).length
      $("[data-behavior='unread-count']").text(noti_length)
    else
      $("[data-behavior='unread-count']").text(0)
    

$(document).ready ->
    new Notifications 
    setInterval () ->
        new Notifications
    , 200