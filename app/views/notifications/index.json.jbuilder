json.array! @notifications do |notification|
  json.notifiable_name notification.notifiable_name
  json.details notification.details
  json.urgency notification.urgency
end