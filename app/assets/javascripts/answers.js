$(document).ready(function() {
  $('.question').click(function() {
    $(this).addClass('open');
    $(this).find('.question-more').slideDown(200);
  });
});
