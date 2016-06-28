(function ($) {

  // Screenshots
  jQuery(document).ready(function () {
    jQuery('a[data-gal]').each(function () {
      jQuery(this).attr('rel', jQuery(this).data('gal'));
    });
    jQuery("a[data-rel^='prettyPhoto']").prettyPhoto({
      overlay_gallery: false,
      social_tools: false
    });
  });

  // Add smooth scrolling to all links inside the navbar
  $(".navbar a").on('click', function(event){

    // Make sure this.hash has a value before overriding default behavior
    if (this.hash !== "") {

      // Prevent default anchor click behavior
      event.preventDefault();

      // Store hash (#)
      var hash = this.hash;

      // Using jQuery's animate() method to add smooth page scroll
      $('html, body').animate({
        scrollTop: $(hash).offset().top
      }, 800, 'swing', function(){

        // Add hash (#) to URL when done scrolling (default click behavior)
        window.location.hash = hash;

      });
    }
  });

})(jQuery);
