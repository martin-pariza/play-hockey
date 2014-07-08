
/*
tab-play-hockey
tab-matches
tab-players
if !signed_in?
  tab-sign-in
else
  tab-player-name
    tab-sign-out
    tab-edit-profile
    tab-delete-profile
*/

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
