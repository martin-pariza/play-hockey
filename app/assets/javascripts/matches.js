/* Sets initial status of page fields. */
function SetFields() {
  $("#match_name").prop("disabled", $("#category-training").is(':checked')); // enable/disable match_name field based on current category selected
  
  var notifySubscribed = $("#send_notification_to_subscribed").is(':checked');
  $("#send_notification_to_others").prop("disabled", !notifySubscribed);
  if (!notifySubscribed) {
    $("#send_notification_to_others").prop("checked", false);
  }
}
