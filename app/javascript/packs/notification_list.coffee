# Run this example by adding <%= javascript_pack_tag 'hello_coffee' %> to the head of your layout file,
# like app/views/layouts/application.html.erb.

$(document).on('turbolinks:load', ->
  $("[data-behavior='notification-link']").on "click", ->
    $.ajax(
      url: "/notifications.json"
      dataType: "JSON"
      method: "GET"
      success: (data) ->
        if Object.keys(data).length != 0
          items = $.map data, (notification) ->
            "<div class='dropdown-item py-2 bg-#{notification.urgency}'>The #{notification.notifiable_name} #{notification.details} </div>"
          items.reverse()
          $("[data-behavior='notification-items']").html(items)
        else
          empty_noti = "<div class='dropdown-item py-2'> No New Notification </div>"
          $("[data-behavior='notification-items']").html(empty_noti)
    )
    $.ajax(
      url: "/notifications/mark_as_read"
      dataType: "JSON"
      method: "POST"
      success: ->
        $("[data-behavior='unread-count']").text(0)
    )
)

