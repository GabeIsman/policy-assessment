$(document).on('cocoon:after-insert', '.question-edit-list', function() {
  var orderFields = $(this).find('.order-field');
  var fieldToUpdate = orderFields.last();
  fieldToUpdate.val(orderFields.length);
});

$(document).ready(function() {
  // Make all the links in questions open in new tabs
  $('.question a').each(function() { $(this).attr('target', '_blank'); });
})
