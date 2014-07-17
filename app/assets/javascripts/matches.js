  /* Sets initial status of page fields. */
  function SetFields() {
    $("#match_name").prop("disabled", $("#category-training").is(':checked')); // enable/disable match_name field based on current category selected
  }
