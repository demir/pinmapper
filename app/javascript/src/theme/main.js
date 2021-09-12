(function ($) {

  "use strict";

  $(document).on('turbo:load', function () {
    // Mobile Menu
    const hamburger = document.getElementById("hamburger");
    if (hamburger) {
      hamburger.addEventListener("click", function (event) {
        document.querySelector(".nav-menu").classList.toggle("active");
        hamburger.classList.toggle("is-active")
      });
    }

    //Scroll to top
    $(window).on('scroll', function () {
      'use strict';
      if ($(this).scrollTop() != 0) {
        $('#toTop').fadeIn();
      } else {
        $('#toTop').fadeOut();
      }
    });
    $('#toTop').on('click', function () {
      $('body,html').animate({
        scrollTop: 0
      }, 500);
    });
  });
})(window.jQuery);


