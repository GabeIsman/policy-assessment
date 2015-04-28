$(document).ready(function() {
  if (window.bootstrapData && window.bootstrapData.assessment) {
    var assessment = new PA.Assessment(bootstrapData.assessment);
  }
})
