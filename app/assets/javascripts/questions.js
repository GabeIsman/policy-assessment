$(document).ready(function() {
  $('.question-edit-list').on('cocoon:after-insert', function() {
    var orderFields = $(this).find('.order-field');
    var fieldToUpdate = orderFields.last();
    fieldToUpdate.val(orderFields.length);
  });
});
