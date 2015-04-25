$(document).on('cocoon:after-insert', '.question-edit-list', function() {
  var orderFields = $(this).find('.order-field');
  var fieldToUpdate = orderFields.last();
  fieldToUpdate.val(orderFields.length);
});
