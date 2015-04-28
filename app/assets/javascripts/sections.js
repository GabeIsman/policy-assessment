$(document).on('click', '.section-header', function() {
  var section = $(this).parent();

  if (section.hasClass('active')) {
    $.publish('section:close', { id: section.data('id') });
    section.removeClass('active');
    section.find('.answers').slideUp(300);
  } else {
    $.publish('section:open', { id: section.data('id') });
    var activeSections = $('.section.active');
    activeSections.find('.answers').slideUp(300);
    activeSections.removeClass('active');
    section.addClass('active');
    section.find('.answers').slideDown(300, function() {
      $('html,body').animate({
        scrollTop: section.offset().top
      }, 300);
    });
  }
})
