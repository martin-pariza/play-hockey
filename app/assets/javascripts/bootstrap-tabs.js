
function ActivateTab(tabName) {
  // foreach tab -> remove "active" class
  // set "active" class for tabName

  $("#tab-play-hockey").removeClass("active");
  $("#tab-matches").removeClass("active");
  $("#tab-players").removeClass("active");
  $("#tab-sign-in").removeClass("active");

  if (tabName.length > 0) {
    $("#" + tabName).addClass("active");
  }
}
